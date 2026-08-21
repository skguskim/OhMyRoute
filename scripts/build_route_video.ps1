[CmdletBinding()]
param(
    # 파이프(|)로 구분된 사진 URL 목록. -File로 자식 프로세스를 띄울 때 PowerShell의
    # CLI 매개변수 바인더가 여러 값을 [string[]]로 안정적으로 묶어주지 않아서
    # (뒤 값이 다음 매개변수로 잘못 바인딩됨) 문자열 하나로 받아 직접 분리한다.
    [Parameter(Mandatory = $true)]
    [string]$ImageUrls,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [int]$MaxPhotos = 8
)

$ErrorActionPreference = "Stop"
$ImageUrlList = @($ImageUrls -split '\|' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

$Root = Split-Path -Parent $PSScriptRoot
$OpenClip = Join-Path $Root "data\video\character_open_frame.mp4"
$MovingClip = Join-Path $Root "data\video\character_moving_frame.mp4"

# 두 캐릭터 소스 클립에서 실측한 값(더 이상 바뀌지 않는 고정 에셋이므로 하드코딩).
# character_open_frame.mp4: 1920x1080/30fps/245프레임(8.166667s), 실제 그림은 1440폭 중앙에
# 그려져 있고 좌우 240px 안팎이 검은 필러박스라 crop=1440:1080:229:0으로 잘라낸다.
# character_moving_frame.mp4: 1440x1080/30fps/158프레임(5.266667s), 필러박스 없음.
$OpenCropFilter = "crop=1440:1080:229:0"
$OpenDuration = 4.083333   # 8.166667 / 2 (2배속)
$MoveDuration = 3.511111   # 5.266667 / 1.5 (1.5배속)
# 결과 프리뷰가 실제로 뜨는 카드가 작아서(~230px 높이) 1440:1080까지 필요 없다.
# 캐릭터 크로마키/erosion은 화질 유지를 위해 계속 1440:1080 원본에서 계산하고,
# alphamerge 이후에만 이 Canvas 크기로 축소해 배경과 합성한다.
$Canvas = "960:720"

# 그린스크린 실측 색상(두 클립 공통, RGB 23,195,31 계열) 및 크로마키/알파 정리 파라미터.
# similarity/blend을 더 키우면 캐릭터 몸통(파란색)이나 문/벽 그림까지 같이 키가 되어 사라지므로
# 이 값들은 임의로 올리지 말 것 — 실측 검증됨.
$ChromaColor = "0x17c31f"
$ChromaSimilarity = "0.08"
$ChromaBlend = "0.04"
$AlphaThreshold = 210

function Get-CleanCharacterChain {
    param([string]$InputLabel, [string]$KeyedLabel1, [string]$KeyedLabel2, [string]$AlphaLabel)
    return "chromakey=${ChromaColor}:${ChromaSimilarity}:${ChromaBlend},erosion,erosion,format=yuva420p,split=2[$KeyedLabel1][$KeyedLabel2];" +
           "[$KeyedLabel2]alphaextract,lut=y='if(gte(val,$AlphaThreshold),255,0)'[$AlphaLabel];"
}

function Get-BackgroundChain {
    param([string]$InputRef, [string]$OutLabel)
    return "[$InputRef]scale=${Canvas}:force_original_aspect_ratio=increase,crop=${Canvas},setsar=1,fps=30[$OutLabel];"
}

function New-RouteVideoError {
    param([string]$Message)
    $errorPath = [System.IO.Path]::ChangeExtension($OutputPath, $null).TrimEnd('.') + ".error.json"
    $payload = @{ status = "error"; message = $Message } | ConvertTo-Json -Compress
    [System.IO.File]::WriteAllText($errorPath, $payload, [System.Text.Encoding]::UTF8)
}

try {
    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
        throw "ffmpeg 실행 파일을 찾을 수 없습니다(PATH 확인 필요)."
    }

    $urls = @($ImageUrlList | Select-Object -First $MaxPhotos)
    if (-not $urls -or $urls.Count -eq 0) {
        throw "사용 가능한 사진 URL이 없습니다."
    }

    $workDir = Join-Path $env:TEMP ("ohmyroute-route-video\" + [System.IO.Path]::GetFileNameWithoutExtension($OutputPath))
    New-Item -ItemType Directory -Force -Path $workDir | Out-Null

    $photoPaths = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt $urls.Count; $i++) {
        $dest = Join-Path $workDir ("photo_{0:d2}.jpg" -f $i)
        try {
            Invoke-WebRequest -Uri $urls[$i] -OutFile $dest -TimeoutSec 15 -UseBasicParsing
            if ((Get-Item $dest).Length -gt 1024) {
                $photoPaths.Add($dest)
            }
        }
        catch {
            # 다운로드 실패한 사진은 건너뛰고 순서만 유지 — 세그먼트 수가 그만큼 줄어든다.
            continue
        }
    }

    if ($photoPaths.Count -eq 0) {
        throw "모든 사진 다운로드에 실패했습니다."
    }

    $photoCount = $photoPaths.Count

    # ffmpeg 입력 목록: 0=open, 1=moving, 2..(N+1)=사진들
    $inputArgs = New-Object System.Collections.Generic.List[string]
    $inputArgs.Add("-i"); $inputArgs.Add($OpenClip)
    $inputArgs.Add("-i"); $inputArgs.Add($MovingClip)
    foreach ($p in $photoPaths) {
        $inputArgs.Add("-loop"); $inputArgs.Add("1")
        $inputArgs.Add("-t"); $inputArgs.Add("6")
        $inputArgs.Add("-i"); $inputArgs.Add($p)
    }

    $filterParts = New-Object System.Collections.Generic.List[string]
    $labelCounter = 0
    function Next-Label { $script:labelCounter++; return "l$($script:labelCounter)" }

    $segmentLabels = New-Object System.Collections.Generic.List[string]

    # OPEN 세그먼트: 사진[0] 배경 + open_frame 정방향 2배속
    $bgOpen = Next-Label
    $filterParts.Add((Get-BackgroundChain -InputRef "2:v" -OutLabel $bgOpen))
    $k1 = Next-Label; $k2 = Next-Label; $a1 = Next-Label; $chrOpen = Next-Label; $segOpen = Next-Label
    $filterParts.Add("[0:v]$OpenCropFilter," + (Get-CleanCharacterChain -KeyedLabel1 $k1 -KeyedLabel2 $k2 -AlphaLabel $a1))
    $filterParts.Add("[$k1][$a1]alphamerge,setpts=PTS/2,fps=30,scale=${Canvas}[$chrOpen];")
    $filterParts.Add("[$bgOpen][$chrOpen]overlay=0:0:shortest=1:format=auto,trim=duration=$OpenDuration,setpts=PTS-STARTPTS[$segOpen];")
    $segmentLabels.Add($segOpen)

    # MOVE 세그먼트 (사진 수 - 1개): 사진[i]->사진[i+1] 슬라이드 배경 + moving_frame 1.5배속
    #
    # moving_frame.mp4에 대한 크로마키/erosion/alphamerge 결과는 모든 move 세그먼트에서
    # 완전히 동일하다(배경 사진만 다를 뿐 캐릭터 클립·속도는 항상 같음). 예전에는 이 무거운
    # 체인을 세그먼트마다(사진 수-1번) 처음부터 다시 계산해서 사진이 많을수록 렌더링 시간이
    # 거의 선형으로 늘어났다. 이제는 딱 한 번만 계산한 뒤 split으로 복사해서 재사용한다.
    $moveCount = $photoCount - 1
    $moveCharLabels = New-Object System.Collections.Generic.List[string]
    if ($moveCount -gt 0) {
        $k3 = Next-Label; $k4 = Next-Label; $a2 = Next-Label; $chrMoveMerged = Next-Label
        $filterParts.Add("[1:v]" + (Get-CleanCharacterChain -KeyedLabel1 $k3 -KeyedLabel2 $k4 -AlphaLabel $a2))
        $filterParts.Add("[$k3][$a2]alphamerge,setpts=PTS/1.5,fps=30,scale=${Canvas}[$chrMoveMerged];")

        if ($moveCount -eq 1) {
            $moveCharLabels.Add($chrMoveMerged)
        }
        else {
            for ($j = 0; $j -lt $moveCount; $j++) {
                $moveCharLabels.Add((Next-Label))
            }
            $splitOut = ($moveCharLabels | ForEach-Object { "[$_]" }) -join ""
            $filterParts.Add("[$chrMoveMerged]split=$moveCount$splitOut;")
        }
    }

    for ($i = 0; $i -lt $moveCount; $i++) {
        $srcA = 2 + $i
        $srcB = 3 + $i
        $bgA = Next-Label; $bgB = Next-Label; $bgMove = Next-Label
        $filterParts.Add("[${srcA}:v]scale=${Canvas}:force_original_aspect_ratio=increase,crop=${Canvas},setsar=1,fps=30,trim=duration=$MoveDuration,setpts=PTS-STARTPTS[$bgA];")
        $filterParts.Add("[${srcB}:v]scale=${Canvas}:force_original_aspect_ratio=increase,crop=${Canvas},setsar=1,fps=30,trim=duration=$MoveDuration,setpts=PTS-STARTPTS[$bgB];")
        $filterParts.Add("[$bgA][$bgB]xfade=transition=slideleft:duration=${MoveDuration}:offset=0[$bgMove];")

        $segMove = Next-Label
        $filterParts.Add("[$bgMove][$($moveCharLabels[$i])]overlay=0:0:shortest=1:format=auto[$segMove];")
        $segmentLabels.Add($segMove)
    }

    # CLOSE 세그먼트: 마지막 사진 배경 + open_frame 역재생 2배속
    $lastSrc = 2 + ($photoCount - 1)
    $bgClose = Next-Label
    $filterParts.Add((Get-BackgroundChain -InputRef "${lastSrc}:v" -OutLabel $bgClose))
    $k5 = Next-Label; $k6 = Next-Label; $a3 = Next-Label; $chrClose = Next-Label; $segClose = Next-Label
    $filterParts.Add("[0:v]$OpenCropFilter," + (Get-CleanCharacterChain -KeyedLabel1 $k5 -KeyedLabel2 $k6 -AlphaLabel $a3))
    $filterParts.Add("[$k5][$a3]alphamerge,reverse,setpts=PTS/2,fps=30,scale=${Canvas}[$chrClose];")
    $filterParts.Add("[$bgClose][$chrClose]overlay=0:0:shortest=1:format=auto,trim=duration=$OpenDuration,setpts=PTS-STARTPTS[$segClose];")
    $segmentLabels.Add($segClose)

    # 전체 세그먼트 concat
    $concatInputs = ($segmentLabels | ForEach-Object { "[$_]" }) -join ""
    $filterParts.Add("$concatInputs" + "concat=n=$($segmentLabels.Count):v=1:a=0[out]")

    $filterComplex = [string]::Join("", $filterParts)

    $outputDir = Split-Path -Parent $OutputPath
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
    }
    $tempOutput = "$OutputPath.tmp.mp4"

    $ffmpegArgs = New-Object System.Collections.Generic.List[string]
    $ffmpegArgs.AddRange($inputArgs)
    $ffmpegArgs.AddRange([string[]]@(
        "-y", "-v", "error",
        "-filter_complex", $filterComplex,
        "-map", "[out]",
        "-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "20", "-preset", "veryfast", "-r", "30",
        $tempOutput
    ))

    & ffmpeg @($ffmpegArgs.ToArray())
    if ($LASTEXITCODE -ne 0) {
        throw "ffmpeg 렌더링 실패(exit $LASTEXITCODE)."
    }

    Move-Item -Force $tempOutput $OutputPath
}
catch {
    New-RouteVideoError -Message $_.Exception.Message
    Write-Error $_
    exit 1
}
finally {
    if (Test-Path $workDir) {
        Remove-Item -Recurse -Force $workDir -ErrorAction SilentlyContinue
    }
}

param(
    [int]$Port = 4173,
    [switch]$NoBrowser,
    [string]$RootPath = $PSScriptRoot,
    [string]$EnvFile = ""
)

$ErrorActionPreference = "Stop"
$Root = [System.IO.Path]::GetFullPath($RootPath)
$Utf8 = New-Object System.Text.UTF8Encoding($false)

Add-Type -AssemblyName System.Net.Http
Add-Type -AssemblyName System.Web

function Import-DotEnv([string]$Path) {
    if (-not [System.IO.File]::Exists($Path)) { return }
    foreach ($rawLine in [System.IO.File]::ReadAllLines($Path, $Utf8)) {
        $line = $rawLine.Trim()
        if (-not $line -or $line.StartsWith("#")) { continue }
        $separator = $line.IndexOf("=")
        if ($separator -le 0) { continue }
        $name = $line.Substring(0, $separator).Trim()
        $value = $line.Substring($separator + 1).Trim()
        if ($value.Length -ge 2) {
            $quoted = ($value.StartsWith('"') -and $value.EndsWith('"')) -or
                      ($value.StartsWith("'") -and $value.EndsWith("'"))
            if ($quoted) { $value = $value.Substring(1, $value.Length - 2) }
        }
        if ($name -match '^[A-Za-z_][A-Za-z0-9_]*$' -and
            [string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($name, "Process"))) {
            [Environment]::SetEnvironmentVariable($name, $value, "Process")
        }
    }
}

if ([string]::IsNullOrWhiteSpace($EnvFile)) {
    $EnvFile = Join-Path $Root ".env"
}
Import-DotEnv ([System.IO.Path]::GetFullPath($EnvFile))
$KmaServiceKey = [Environment]::GetEnvironmentVariable("KMA_API_SERVICE_KEY", "Process")
if ([string]::IsNullOrWhiteSpace($KmaServiceKey)) {
    $KmaServiceKey = [Environment]::GetEnvironmentVariable("KMA_SERVICE_KEY", "Process")
}
if (-not [string]::IsNullOrWhiteSpace($KmaServiceKey) -and $KmaServiceKey.Contains("%")) {
    try { $KmaServiceKey = [System.Uri]::UnescapeDataString($KmaServiceKey) } catch { }
}

function Get-ContentType([string]$Path) {
    switch ([System.IO.Path]::GetExtension($Path).ToLowerInvariant()) {
        ".html" { return "text/html; charset=utf-8" }
        ".htm"  { return "text/html; charset=utf-8" }
        ".js"   { return "text/javascript; charset=utf-8" }
        ".mjs"  { return "text/javascript; charset=utf-8" }
        ".css"  { return "text/css; charset=utf-8" }
        ".json" { return "application/json; charset=utf-8" }
        ".csv"  { return "text/csv; charset=utf-8" }
        ".txt"  { return "text/plain; charset=utf-8" }
        ".svg"  { return "image/svg+xml" }
        ".png"  { return "image/png" }
        ".jpg"  { return "image/jpeg" }
        ".jpeg" { return "image/jpeg" }
        ".gif"  { return "image/gif" }
        ".webp" { return "image/webp" }
        ".ico"  { return "image/x-icon" }
        ".mp4"  { return "video/mp4" }
        ".pdf"  { return "application/pdf" }
        default  { return "application/octet-stream" }
    }
}

function Send-Response(
    [System.IO.Stream]$Stream,
    [int]$StatusCode,
    [string]$StatusText,
    [string]$ContentType,
    [byte[]]$Body,
    [bool]$HeadOnly
) {
    if ($null -eq $Body) {
        $Body = [byte[]]@()
    }

    $header = "HTTP/1.1 $StatusCode $StatusText`r`n" +
              "Content-Type: $ContentType`r`n" +
              "Content-Length: $($Body.Length)`r`n" +
              "Cache-Control: no-cache`r`n" +
              "Connection: close`r`n`r`n"
    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
    $Stream.Write($headerBytes, 0, $headerBytes.Length)
    if (-not $HeadOnly -and $Body.Length -gt 0) {
        $Stream.Write($Body, 0, $Body.Length)
    }
    $Stream.Flush()
}

function Send-JsonError(
    [System.IO.Stream]$Stream,
    [int]$StatusCode,
    [string]$StatusText,
    [string]$Code,
    [string]$Message,
    [bool]$HeadOnly
) {
    $json = @{ error = @{ code = $Code; message = $Message } } | ConvertTo-Json -Compress
    Send-Response $Stream $StatusCode $StatusText "application/json; charset=utf-8" $Utf8.GetBytes($json) $HeadOnly
}

function Test-WeatherQuery([System.Collections.Specialized.NameValueCollection]$Query) {
    if ($Query["base_date"] -notmatch '^\d{8}$') { return $false }
    if ($Query["base_time"] -notmatch '^\d{4}$') { return $false }
    if ($Query["nx"] -notmatch '^\d{1,3}$' -or [int]$Query["nx"] -lt 1 -or [int]$Query["nx"] -gt 200) { return $false }
    if ($Query["ny"] -notmatch '^\d{1,3}$' -or [int]$Query["ny"] -lt 1 -or [int]$Query["ny"] -gt 200) { return $false }
    return $true
}

function Test-MidWeatherQuery([System.Collections.Specialized.NameValueCollection]$Query) {
    if ($Query["tm_fc"] -notmatch '^\d{12}$') { return $false }
    $hour = $Query["tm_fc"].Substring(8, 2)
    if ($hour -ne "06" -and $hour -ne "18") { return $false }
    return $true
}

$RouteVideoOutputDir = Join-Path $Root "outputs\route-video"
$RouteVideoScript = Join-Path $Root "scripts\build_route_video.ps1"
$RouteVideoMaxPhotos = 8

$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)

try {
    $listener.Start()
    Write-Host ""
    Write-Host "Omaeroute server is running."
    Write-Host "Open: http://localhost:$Port/"
    Write-Host $(if ([string]::IsNullOrWhiteSpace($KmaServiceKey)) { "KMA weather proxy: key not configured" } else { "KMA weather proxy: ready" })
    Write-Host "Keep this window open. Press Ctrl+C to stop."
    Write-Host ""

    if (-not $NoBrowser) {
        Start-Process "http://localhost:$Port/"
    }

    while ($true) {
        $client = $listener.AcceptTcpClient()
        $client.NoDelay = $true
        $client.ReceiveTimeout = 5000
        $client.SendTimeout = 5000
        $stream = $null
        $reader = $null

        try {
            $stream = $client.GetStream()
            $stream.ReadTimeout = 5000
            $stream.WriteTimeout = 5000
            $reader = New-Object System.IO.StreamReader(
                $stream,
                [System.Text.Encoding]::ASCII,
                $false,
                1024,
                $true
            )

            $requestLine = $reader.ReadLine()
            if ([string]::IsNullOrWhiteSpace($requestLine)) {
                continue
            }

            $contentLength = 0
            do {
                $line = $reader.ReadLine()
                if ($null -ne $line -and $line -match '^Content-Length:\s*(\d+)$') {
                    $contentLength = [int]$Matches[1]
                }
            } while ($null -ne $line -and $line.Length -gt 0)

            $parts = $requestLine.Split(" ")
            if ($parts.Length -lt 2) {
                $body = $Utf8.GetBytes("400 Bad Request")
                Send-Response $stream 400 "Bad Request" "text/plain; charset=utf-8" $body $false
                continue
            }

            $method = $parts[0].ToUpperInvariant()
            $headOnly = $method -eq "HEAD"
            $requestUri = [System.Uri]::new("http://localhost$($parts[1])")
            $isRouteVideoSubmit = $method -eq "POST" -and $requestUri.AbsolutePath -eq "/api/route-video"

            if ($method -ne "GET" -and -not $headOnly -and -not $isRouteVideoSubmit) {
                $body = $Utf8.GetBytes("405 Method Not Allowed")
                Send-Response $stream 405 "Method Not Allowed" "text/plain; charset=utf-8" $body $false
                continue
            }

            if ($isRouteVideoSubmit) {
                $requestBody = ""
                if ($contentLength -gt 0) {
                    $buffer = New-Object char[] $contentLength
                    $readCount = $reader.ReadBlock($buffer, 0, $contentLength)
                    $requestBody = -join $buffer[0..($readCount - 1)]
                }

                $payload = $null
                try { $payload = $requestBody | ConvertFrom-Json } catch { }
                $imageUrls = @()
                if ($null -ne $payload -and $null -ne $payload.imageUrls) {
                    $imageUrls = @($payload.imageUrls | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -First $RouteVideoMaxPhotos)
                }

                if ($imageUrls.Count -eq 0) {
                    Send-JsonError $stream 400 "Bad Request" "ROUTE_VIDEO_NO_PHOTOS" "imageUrls 배열이 비어 있습니다." $headOnly
                    continue
                }

                New-Item -ItemType Directory -Force -Path $RouteVideoOutputDir | Out-Null
                $jobId = [Guid]::NewGuid().ToString("N")
                $outputPath = Join-Path $RouteVideoOutputDir "$jobId.mp4"

                $argList = New-Object System.Collections.Generic.List[string]
                $argList.Add("-NoProfile"); $argList.Add("-ExecutionPolicy"); $argList.Add("Bypass")
                $argList.Add("-File"); $argList.Add($RouteVideoScript)
                $argList.Add("-ImageUrls")
                foreach ($url in $imageUrls) { $argList.Add($url) }
                $argList.Add("-OutputPath"); $argList.Add($outputPath)

                Start-Process -FilePath "powershell.exe" -ArgumentList $argList.ToArray() -WindowStyle Hidden | Out-Null

                $json = @{ jobId = $jobId } | ConvertTo-Json -Compress
                Send-Response $stream 202 "Accepted" "application/json; charset=utf-8" $Utf8.GetBytes($json) $headOnly
                continue
            }

            if ($requestUri.AbsolutePath -eq "/api/route-video") {
                $query = [System.Web.HttpUtility]::ParseQueryString($requestUri.Query)
                $jobId = $query["id"]
                if ([string]::IsNullOrWhiteSpace($jobId) -or $jobId -notmatch '^[0-9a-f]{32}$') {
                    Send-JsonError $stream 400 "Bad Request" "ROUTE_VIDEO_INVALID_ID" "id 값을 확인해주세요." $headOnly
                    continue
                }
                $videoPath = Join-Path $RouteVideoOutputDir "$jobId.mp4"
                $errorPath = Join-Path $RouteVideoOutputDir "$jobId.error.json"
                if ([System.IO.File]::Exists($videoPath)) {
                    $videoBody = [System.IO.File]::ReadAllBytes($videoPath)
                    Send-Response $stream 200 "OK" "video/mp4" $videoBody $headOnly
                }
                elseif ([System.IO.File]::Exists($errorPath)) {
                    $errorJson = [System.IO.File]::ReadAllText($errorPath, $Utf8)
                    Send-Response $stream 502 "Bad Gateway" "application/json; charset=utf-8" $Utf8.GetBytes($errorJson) $headOnly
                }
                else {
                    $json = @{ status = "pending" } | ConvertTo-Json -Compress
                    Send-Response $stream 202 "Accepted" "application/json; charset=utf-8" $Utf8.GetBytes($json) $headOnly
                }
                continue
            }

            if ($requestUri.AbsolutePath -eq "/api/weather") {
                if ([string]::IsNullOrWhiteSpace($KmaServiceKey)) {
                    Send-JsonError $stream 503 "Service Unavailable" "KMA_KEY_MISSING" ".env에 KMA_API_SERVICE_KEY를 설정해주세요." $headOnly
                    continue
                }
                $query = [System.Web.HttpUtility]::ParseQueryString($requestUri.Query)
                if (-not (Test-WeatherQuery $query)) {
                    Send-JsonError $stream 400 "Bad Request" "KMA_INVALID_QUERY" "base_date, base_time, nx, ny 값을 확인해주세요." $headOnly
                    continue
                }
                $encodedKey = [System.Uri]::EscapeDataString($KmaServiceKey)
                $upstreamUrl = "https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst" +
                               "?serviceKey=$encodedKey&pageNo=1&numOfRows=2000&dataType=JSON" +
                               "&base_date=$($query['base_date'])&base_time=$($query['base_time'])" +
                               "&nx=$($query['nx'])&ny=$($query['ny'])"
                $httpClient = [System.Net.Http.HttpClient]::new()
                $httpClient.Timeout = [TimeSpan]::FromSeconds(12)
                try {
                    $upstream = $httpClient.GetAsync($upstreamUrl).GetAwaiter().GetResult()
                    $responseBody = $upstream.Content.ReadAsByteArrayAsync().GetAwaiter().GetResult()
                    $contentType = if ($null -ne $upstream.Content.Headers.ContentType) {
                        $upstream.Content.Headers.ContentType.ToString()
                    } else {
                        "application/json; charset=utf-8"
                    }
                    Send-Response $stream ([int]$upstream.StatusCode) $upstream.ReasonPhrase $contentType $responseBody $headOnly
                }
                catch {
                    Send-JsonError $stream 502 "Bad Gateway" "KMA_UPSTREAM_FAILED" "기상청 API 연결에 실패했습니다. 잠시 후 다시 시도해주세요." $headOnly
                }
                finally {
                    $httpClient.Dispose()
                }
                continue
            }

            if ($requestUri.AbsolutePath -eq "/api/weather/mid-land" -or
                $requestUri.AbsolutePath -eq "/api/weather/mid-temperature") {
                if ([string]::IsNullOrWhiteSpace($KmaServiceKey)) {
                    Send-JsonError $stream 503 "Service Unavailable" "KMA_KEY_MISSING" ".env에 KMA_API_SERVICE_KEY를 설정해주세요." $headOnly
                    continue
                }
                $query = [System.Web.HttpUtility]::ParseQueryString($requestUri.Query)
                if (-not (Test-MidWeatherQuery $query)) {
                    Send-JsonError $stream 400 "Bad Request" "KMA_INVALID_MID_QUERY" "tm_fc 값을 확인해주세요." $headOnly
                    continue
                }
                $encodedKey = [System.Uri]::EscapeDataString($KmaServiceKey)
                $isLandForecast = $requestUri.AbsolutePath -eq "/api/weather/mid-land"
                $endpoint = if ($isLandForecast) { "getMidLandFcst" } else { "getMidTa" }
                $regionId = if ($isLandForecast) { "11F20000" } else { "11F20501" }
                $upstreamUrl = "https://apis.data.go.kr/1360000/MidFcstInfoService/$endpoint" +
                               "?serviceKey=$encodedKey&pageNo=1&numOfRows=10&dataType=JSON" +
                               "&regId=$regionId&tmFc=$($query['tm_fc'])"
                $httpClient = [System.Net.Http.HttpClient]::new()
                $httpClient.Timeout = [TimeSpan]::FromSeconds(12)
                try {
                    $upstream = $httpClient.GetAsync($upstreamUrl).GetAwaiter().GetResult()
                    $responseBody = $upstream.Content.ReadAsByteArrayAsync().GetAwaiter().GetResult()
                    $contentType = if ($null -ne $upstream.Content.Headers.ContentType) {
                        $upstream.Content.Headers.ContentType.ToString()
                    } else {
                        "application/json; charset=utf-8"
                    }
                    Send-Response $stream ([int]$upstream.StatusCode) $upstream.ReasonPhrase $contentType $responseBody $headOnly
                }
                catch {
                    Send-JsonError $stream 502 "Bad Gateway" "KMA_MID_UPSTREAM_FAILED" "기상청 중기예보 API 연결에 실패했습니다. 잠시 후 다시 시도해주세요." $headOnly
                }
                finally {
                    $httpClient.Dispose()
                }
                continue
            }

            $rawPath = $parts[1].Split("?")[0]
            $decodedPath = [System.Uri]::UnescapeDataString($rawPath)
            $relativePath = $decodedPath.TrimStart("/").Replace("/", [System.IO.Path]::DirectorySeparatorChar)
            if ([string]::IsNullOrWhiteSpace($relativePath)) {
                $relativePath = "index.html"
            }

            $fullPath = [System.IO.Path]::GetFullPath((Join-Path $Root $relativePath))
            $rootPrefix = $Root.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
            $insideRoot = $fullPath.Equals($Root, [System.StringComparison]::OrdinalIgnoreCase) -or
                          $fullPath.StartsWith($rootPrefix, [System.StringComparison]::OrdinalIgnoreCase)

            if (-not $insideRoot) {
                $body = $Utf8.GetBytes("403 Forbidden")
                Send-Response $stream 403 "Forbidden" "text/plain; charset=utf-8" $body $headOnly
                continue
            }

            if ([System.IO.Directory]::Exists($fullPath)) {
                $fullPath = Join-Path $fullPath "index.html"
            }

            if (-not [System.IO.File]::Exists($fullPath)) {
                $body = $Utf8.GetBytes("404 Not Found")
                Send-Response $stream 404 "Not Found" "text/plain; charset=utf-8" $body $headOnly
                continue
            }

            $body = [System.IO.File]::ReadAllBytes($fullPath)
            Send-Response $stream 200 "OK" (Get-ContentType $fullPath) $body $headOnly
        }
        catch {
            if ($null -ne $stream) {
                try {
                    $body = $Utf8.GetBytes("500 Internal Server Error")
                    Send-Response $stream 500 "Internal Server Error" "text/plain; charset=utf-8" $body $false
                }
                catch {
                }
            }
        }
        finally {
            if ($null -ne $reader) { $reader.Dispose() }
            if ($null -ne $stream) { $stream.Dispose() }
            $client.Close()
        }
    }
}
catch [System.Net.Sockets.SocketException] {
    Write-Host "Port $Port is already in use." -ForegroundColor Red
    Write-Host "Close the previous server window and run this file again."
    Read-Host "Press Enter to close"
    exit 1
}
finally {
    $listener.Stop()
}

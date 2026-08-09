param(
    [int]$Port = 4173,
    [switch]$NoBrowser,
    [string]$RootPath = $PSScriptRoot
)

$ErrorActionPreference = "Stop"
$Root = [System.IO.Path]::GetFullPath($RootPath)
$Utf8 = New-Object System.Text.UTF8Encoding($false)

function Get-ContentType([string]$Path) {
    switch ([System.IO.Path]::GetExtension($Path).ToLowerInvariant()) {
        ".html" { return "text/html; charset=utf-8" }
        ".htm"  { return "text/html; charset=utf-8" }
        ".js"   { return "text/javascript; charset=utf-8" }
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

$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)

try {
    $listener.Start()
    Write-Host ""
    Write-Host "Omaeroute server is running."
    Write-Host "Open: http://localhost:$Port/"
    Write-Host "Keep this window open. Press Ctrl+C to stop."
    Write-Host ""

    if (-not $NoBrowser) {
        Start-Process "http://localhost:$Port/"
    }

    while ($true) {
        $client = $listener.AcceptTcpClient()
        $stream = $null
        $reader = $null

        try {
            $stream = $client.GetStream()
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

            do {
                $line = $reader.ReadLine()
            } while ($null -ne $line -and $line.Length -gt 0)

            $parts = $requestLine.Split(" ")
            if ($parts.Length -lt 2) {
                $body = $Utf8.GetBytes("400 Bad Request")
                Send-Response $stream 400 "Bad Request" "text/plain; charset=utf-8" $body $false
                continue
            }

            $method = $parts[0].ToUpperInvariant()
            $headOnly = $method -eq "HEAD"
            if ($method -ne "GET" -and -not $headOnly) {
                $body = $Utf8.GetBytes("405 Method Not Allowed")
                Send-Response $stream 405 "Method Not Allowed" "text/plain; charset=utf-8" $body $false
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

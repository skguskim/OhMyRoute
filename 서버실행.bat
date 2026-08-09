@echo off
setlocal
cd /d "%~dp0"

if /I "%~1"=="--check" goto check_ok

title Omaeroute Server
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_server.ps1"
exit /b %errorlevel%

:check_ok
echo READY:powershell
exit /b 0

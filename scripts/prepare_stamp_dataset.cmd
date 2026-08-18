@echo off
setlocal
chcp 65001 >nul
set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"

set "PROJECT_ROOT=%~dp0.."
set "BUNDLED_PYTHON=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

if exist "%BUNDLED_PYTHON%" (
  set "PYTHON_EXE=%BUNDLED_PYTHON%"
) else (
  where python >nul 2>nul
  if errorlevel 1 (
    echo [ERROR] Python was not found. Install Python 3 or run this project through Codex Desktop.
    exit /b 1
  )
  set "PYTHON_EXE=python"
)

pushd "%PROJECT_ROOT%"
"%PYTHON_EXE%" ".\scripts\prepare_stamp_dataset.py" %*
set "PIPELINE_EXIT=%ERRORLEVEL%"
popd

exit /b %PIPELINE_EXIT%

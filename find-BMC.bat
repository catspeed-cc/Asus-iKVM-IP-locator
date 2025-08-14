@echo off
setlocal

set "PSSCRIPT=%~dp0find-BMC.ps1"

if not exist "%PSSCRIPT%" (
    echo ERROR: find-BMC.ps1 not found!
    echo Expected: "%PSSCRIPT%"
    exit /b 1
)

set "IPRange=%~1"
set "Timeout=%~2"

if "%IPRange%"=="" (
    echo.
    echo Usage: %~n0 IPRange [Timeout]
    echo.
    echo   IPRange  - e.g., 192.168.10
    echo   Timeout  - optional, default 250ms
    echo.
    exit /b 1
)

if "%Timeout%"=="" set "Timeout=250"

:: Validate Timeout is number
set "bad=" & for /f "delims=0123456789" %%i in ("%Timeout%") do set "bad=1"
if defined bad (
    echo ERROR: Timeout must be a number. Got '%Timeout%'
    exit /b 1
)

echo Scanning %IPRange%.x with %Timeout%ms timeout...
powershell -ExecutionPolicy Bypass -Command "& '%PSSCRIPT%' -IPRange '%IPRange%' -Timeout %Timeout%"

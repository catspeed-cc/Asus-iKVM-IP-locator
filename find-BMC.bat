@echo off
:: Find-BMC.bat - Wrapper to run Find-BMC.ps1 with parameters

setlocal

:: PowerShell script path (assumes same directory)
set "PSSCRIPT=%~dp0find-BMC.ps1"

:: Check if PowerShell script exists
if not exist "%PSSCRIPT%" (
    echo ERROR: Could not find Find-BMC.ps1 in the same directory.
    echo Please ensure the PowerShell script is located next to this batch file.
    exit /b 1
)

:: Parse arguments
set "IPRange=%~1"
set "Timeout=%~2"

:: Validate IPRange is provided
if "%IPRange%"=="" (
    echo Usage: %~n0 ^ [Timeout]
    echo Example: %~n0 192.168.10
    echo Example: %~n0 192.168.10 500
    echo.
    echo   IPRange - Required: The first three octets of the network (e.g., 192.168.10)
    echo   Timeout - Optional: Response timeout in ms (default: 250)
    exit /b 1
)

:: Set default timeout if not provided
if "%Timeout%"=="" set "Timeout=250"

:: Validate timeout is a number
for /f "delims=0123456789" %%i in ("%Timeout%") do set "badchar=%%i"
if defined badchar (
    echo ERROR: Timeout must be a number.
    exit /b 1
)

:: Run PowerShell script with bypass execution policy (temporary)
powershell -ExecutionPolicy Bypass -Command "& '%PSSCRIPT%' -IPRange '%IPRange%' -Timeout %Timeout%"

endlocal   

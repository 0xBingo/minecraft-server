@echo off
setlocal

:: Variables
set "MINECRAFT_DOMAIN=mc.example.com"
set "CLOUDFLARED_URL=https://github.com/cloudflare/cloudflared/releases/download/2024.12.2/cloudflared-windows-amd64.exe"
set "CLOUDFLARED_EXE=cloudflared-windows-amd64.exe"
set "DOWNLOAD_DIR=%USERPROFILE%\Downloads"
set "COMMAND_ARGS=access tcp --hostname %MINECRAFT_DOMAIN% --url localhost:22565"

:: Ensure the Downloads folder exists
if not exist "%DOWNLOAD_DIR%" (
    echo Downloads folder not found. Exiting.
    exit /b 1
)

:: Check if cloudflared executable exists in the Downloads folder
if not exist "%DOWNLOAD_DIR%\%CLOUDFLARED_EXE%" (
    echo Downloading cloudflared to the Downloads folder...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%CLOUDFLARED_URL%', '%DOWNLOAD_DIR%\%CLOUDFLARED_EXE%')"
    if %ERRORLEVEL% neq 0 (
        echo Failed to download cloudflared. Exiting.
        exit /b 1
    )
    echo cloudflared downloaded successfully.
) else (
    echo cloudflared already exists in the Downloads folder. Skipping download.
)

:: Execute cloudflared command
echo Executing cloudflared...
"%DOWNLOAD_DIR%\%CLOUDFLARED_EXE%" %COMMAND_ARGS%

endlocal
pause

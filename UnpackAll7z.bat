@echo off
setlocal enabledelayedexpansion

set /p folderPath=Enter the path to the folder you want to unzip (including subfolders): 

set "SevenZipPath="

for /f "tokens=2,*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip" /v Path 2^>nul') do set "SevenZipPath=%%B"
for /f "tokens=2,*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\7-Zip" /v Path 2^>nul') do set "SevenZipPath=%%B"

if not defined SevenZipPath (
    echo Could not find 7-Zip. Make sure you have 7-Zip installed.
    exit /b
)

if "%SevenZipPath:~-1%"=="\" set "SevenZipPath=%SevenZipPath:~0,-1%"

for /r "%folderPath%" %%F in (*.7z) do (
    "!SevenZipPath!\7z.exe" x "%%F" -o"%%~dpF%%~nF" -y
)

endlocal

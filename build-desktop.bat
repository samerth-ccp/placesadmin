@echo off
echo ========================================
echo Places Manager Desktop App Builder
echo ========================================
echo.

echo [1/5] Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo [2/5] Building application...
call npm run build
if %errorlevel% neq 0 (
    echo ERROR: Failed to build application
    pause
    exit /b 1
)

echo.
echo [3/5] Building desktop application...
call npm run electron:build
if %errorlevel% neq 0 (
    echo ERROR: Failed to build desktop application
    pause
    exit /b 1
)

echo.
echo [4/5] Checking build output...
if exist "electron-dist" (
    echo SUCCESS: Desktop application built successfully!
    echo.
    echo Build output location: electron-dist\
    echo.
    dir electron-dist\
) else (
    echo ERROR: Build output not found
    pause
    exit /b 1
)

echo.
echo [5/5] Build complete!
echo.
echo Next steps:
echo 1. Install PowerShell modules (run as Administrator):
echo    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
echo    Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber
echo.
echo 2. Run the application:
echo    npm run electron
echo.
echo 3. Or install from the generated installer in electron-dist\
echo.
pause 
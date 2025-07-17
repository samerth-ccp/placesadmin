# Places Manager PowerShell Module Installer
# Run this script as Administrator

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Places Manager PowerShell Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as Administrator" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[1/6] Setting execution policy..." -ForegroundColor Green
try {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-Host "✓ Execution policy set to RemoteSigned" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to set execution policy: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "[2/6] Installing NuGet provider..." -ForegroundColor Green
try {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
    Write-Host "✓ NuGet provider installed" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install NuGet provider: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "[3/6] Installing ExchangeOnlineManagement module..." -ForegroundColor Green
try {
    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber -Scope CurrentUser
    Write-Host "✓ ExchangeOnlineManagement module installed" -ForegroundColor Green
} catch {
    Write-Host "✗ Failed to install ExchangeOnlineManagement: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "[4/6] Installing Microsoft.Graph.Places module..." -ForegroundColor Green
try {
    Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber -Scope CurrentUser
    Write-Host "✓ Microsoft.Graph.Places module installed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Microsoft.Graph.Places module installation failed" -ForegroundColor Yellow
    Write-Host "   This module may not be available in your PowerShell Gallery" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[5/6] Installing Microsoft.Places.PowerShell module..." -ForegroundColor Green
try {
    Install-Module -Name Microsoft.Places.PowerShell -Force -AllowClobber -Scope CurrentUser
    Write-Host "✓ Microsoft.Places.PowerShell module installed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Microsoft.Places.PowerShell module installation failed" -ForegroundColor Yellow
    Write-Host "   This module may not be available in your PowerShell Gallery" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[6/6] Verifying installations..." -ForegroundColor Green

# Check installed modules
$modules = @("ExchangeOnlineManagement", "Microsoft.Graph.Places", "Microsoft.Places.PowerShell")
$installedModules = Get-Module -Name $modules -ListAvailable

Write-Host ""
Write-Host "Installed modules:" -ForegroundColor Cyan
foreach ($module in $installedModules) {
    Write-Host "  ✓ $($module.Name) v$($module.Version)" -ForegroundColor Green
}

$missingModules = $modules | Where-Object { $_ -notin $installedModules.Name }
if ($missingModules) {
    Write-Host ""
    Write-Host "Missing modules:" -ForegroundColor Yellow
    foreach ($module in $missingModules) {
        Write-Host "  ✗ $module" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "Note: Some modules may not be available in PowerShell Gallery" -ForegroundColor Yellow
    Write-Host "The application will work with the available modules" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "You can now run the Places Manager application:" -ForegroundColor White
Write-Host "  npm run electron" -ForegroundColor Cyan
Write-Host ""
Write-Host "Or build the desktop application:" -ForegroundColor White
Write-Host "  npm run electron:build" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to exit" 
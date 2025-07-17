# Deployment Guide for Places Manager

## Overview

Places Manager requires PowerShell to run, which limits deployment options. Here are the recommended approaches:

## **Option 1: Desktop Application (Recommended)**

### Why Desktop App?
- PowerShell runs natively on Windows
- No server infrastructure needed
- Users can run locally with full functionality
- Secure - no data leaves the user's machine

### Prerequisites
- Windows 10/11 with PowerShell 7+
- Node.js 18+ installed
- Microsoft 365 account with Places Administrator permissions

### Installation Steps

#### 1. Build the Desktop Application
```bash
# Clone the repository
git clone https://github.com/samerth-ccp/placesmanager.git
cd placesmanager

# Install dependencies
npm install

# Build the desktop application
npm run electron:build
```

#### 2. Install PowerShell Modules
Run PowerShell as Administrator:
```powershell
# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install required modules
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber
Install-Module -Name Microsoft.Places.PowerShell -Force -AllowClobber
```

#### 3. Run the Application
```bash
# Development mode
npm run electron:dev

# Production mode
npm run electron
```

#### 4. Distribution
The built application will be in `electron-dist/` folder:
- **Windows**: `.exe` installer
- **macOS**: `.dmg` file
- **Linux**: `.AppImage` file

### Desktop App Features
- ✅ Native Windows application
- ✅ Full PowerShell integration
- ✅ No server required
- ✅ Offline capability
- ✅ Automatic updates (can be configured)
- ✅ Professional installer

---

## **Option 2: Web Application with Windows Server**

### Architecture
- **Frontend**: React app hosted on web server
- **Backend**: Express.js server running on Windows
- **PowerShell**: Executed on Windows server

### Deployment Options

#### A. Azure App Service (Windows)
```bash
# Deploy to Azure App Service
az webapp create --name places-manager --resource-group myResourceGroup --plan myAppServicePlan --runtime "NODE|18-lts"

# Deploy the application
az webapp deployment source config-zip --resource-group myResourceGroup --name places-manager --src dist.zip
```

#### B. AWS EC2 Windows Server
```bash
# Launch Windows Server EC2 instance
# Install Node.js and PowerShell modules
# Deploy application using PM2 or Windows Service
```

#### C. On-Premises Windows Server
```bash
# Install on Windows Server
# Configure IIS with Node.js
# Set up PowerShell execution policies
```

### Web Deployment Steps

#### 1. Prepare for Web Deployment
```bash
# Build the application
npm run build

# Create production bundle
npm run start
```

#### 2. Server Configuration
```powershell
# On Windows Server, install required modules
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber

# Configure PowerShell execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

#### 3. Environment Variables
```bash
# Set production environment variables
NODE_ENV=production
PORT=5000
POWERSHELL_PATH=pwsh
```

#### 4. Process Management
```bash
# Using PM2
npm install -g pm2
pm2 start dist/index.js --name "places-manager"

# Using Windows Service
npm install -g node-windows
node-windows install
```

---

## **Option 3: Hybrid Approach**

### Architecture
- **Desktop App**: For Windows users (full functionality)
- **Web App**: For non-Windows users (demo mode)
- **Shared Backend**: Common API endpoints

### Implementation
```typescript
// Detect platform and show appropriate interface
const isWindows = navigator.platform.includes('Win');
const isElectron = window.electron !== undefined;

if (isWindows && isElectron) {
  // Full functionality
  showFullInterface();
} else {
  // Demo mode with limited functionality
  showDemoInterface();
}
```

---

## **Security Considerations**

### Desktop App Security
- ✅ No network exposure
- ✅ Local PowerShell execution
- ✅ User controls their own data
- ✅ No server vulnerabilities

### Web App Security
- ⚠️ PowerShell execution on server
- ⚠️ Network exposure
- ⚠️ Authentication required
- ⚠️ Server security needed

### Recommended Security Measures
```bash
# Use HTTPS for web deployment
# Implement proper authentication
# Restrict PowerShell execution
# Monitor server logs
# Regular security updates
```

---

## **Distribution Methods**

### 1. Desktop App Distribution
```bash
# Create installer
npm run electron:build

# Upload to GitHub Releases
# Use GitHub Actions for automated builds
# Provide download links for users
```

### 2. Web App Distribution
```bash
# Deploy to cloud platform
# Set up custom domain
# Configure SSL certificates
# Set up monitoring and logging
```

### 3. Enterprise Distribution
```bash
# Package for enterprise deployment
# Use Group Policy for installation
# Configure automatic updates
# Set up centralized management
```

---

## **Troubleshooting**

### Common Issues

#### PowerShell Module Issues
```powershell
# Clear module cache
Remove-Module -Name ExchangeOnlineManagement -Force
Import-Module ExchangeOnlineManagement

# Update modules
Update-Module -Name ExchangeOnlineManagement
```

#### Authentication Issues
```powershell
# Clear existing sessions
Disconnect-ExchangeOnline -Confirm:$false

# Reconnect with explicit credentials
Connect-ExchangeOnline -UserPrincipalName "admin@domain.com"
```

#### Desktop App Issues
```bash
# Clear Electron cache
rm -rf ~/.config/places-manager

# Rebuild application
npm run electron:build
```

---

## **Recommended Approach**

For your use case, I recommend **Option 1 (Desktop Application)** because:

1. **PowerShell Dependency**: Your app requires PowerShell, which is Windows-specific
2. **Security**: No server infrastructure needed, data stays local
3. **Simplicity**: Users just download and run
4. **Cost**: No ongoing server costs
5. **Performance**: Direct PowerShell execution, no network latency

### Next Steps
1. Build the desktop application
2. Test on Windows machines
3. Create installer package
4. Distribute to users
5. Provide installation instructions

The desktop app approach gives you the best user experience while maintaining the PowerShell functionality your application requires.
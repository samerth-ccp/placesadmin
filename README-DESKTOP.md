# Places Manager - Desktop Application

A powerful desktop application for managing Microsoft Places with full PowerShell integration.

## 🚀 Quick Start

### Prerequisites
- **Windows 10/11** with PowerShell 7+
- **Node.js 18+** installed
- **Microsoft 365** account with Places Administrator permissions

### Installation

#### Option 1: Download Pre-built Application
1. Download the latest release from [GitHub Releases](https://github.com/samerth-ccp/placesmanager/releases)
2. Run the installer (`Places Manager Setup.exe`)
3. Follow the installation wizard

#### Option 2: Build from Source
```bash
# Clone the repository
git clone https://github.com/samerth-ccp/placesmanager.git
cd placesmanager

# Install dependencies
npm install

# Build the desktop application
npm run electron:build

# Run the application
npm run electron
```

### PowerShell Setup
Run PowerShell as Administrator and execute:
```powershell
# Run the automated setup script
.\install-powershell-modules.ps1

# Or manually install modules
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber
```

## 🖥️ Features

### Desktop Application Benefits
- ✅ **Native Windows Experience** - Runs as a desktop app
- ✅ **Full PowerShell Integration** - Direct access to Microsoft 365
- ✅ **Offline Capability** - Works without internet (after initial setup)
- ✅ **No Server Required** - Everything runs locally
- ✅ **Secure** - No data leaves your machine
- ✅ **Professional UI** - Modern, responsive interface

### Core Features
- 🔐 **Microsoft 365 Authentication** - Secure connection to your tenant
- 🏢 **Places Management** - Create and manage buildings, floors, sections, desks, rooms
- 📊 **Hierarchy Viewer** - Visual tree structure of your places
- 💻 **PowerShell Console** - Interactive command execution
- 📝 **Command History** - Track and replay commands
- 🔄 **Auto-sync** - Keep local data in sync with Microsoft Places

## 🛠️ Development

### Running in Development Mode
```bash
# Start the development server and Electron
npm run electron:dev

# Or run separately
npm run dev          # Start Express server
npm run electron     # Start Electron app
```

### Building for Distribution
```bash
# Build the application
npm run build

# Create desktop installer
npm run electron:build

# Output will be in electron-dist/
```

### Project Structure
```
placesmanager/
├── client/                 # React frontend
├── server/                 # Express backend
├── electron/               # Electron main process
├── shared/                 # Shared schemas
├── assets/                 # App icons and assets
├── build-desktop.bat       # Windows build script
├── install-powershell-modules.ps1  # PowerShell setup
└── package.json           # Dependencies and scripts
```

## 🔧 Configuration

### Environment Variables
```bash
# Development
NODE_ENV=development
PORT=5000

# Production
NODE_ENV=production
PORT=5000
POWERSHELL_PATH=pwsh
```

### PowerShell Settings
The application automatically detects and uses:
- PowerShell 7+ (pwsh) if available
- Falls back to Windows PowerShell (powershell.exe)
- Configures execution policies automatically

## 🚀 Deployment Options

### 1. Desktop Application (Recommended)
- **Best for**: Individual users, small teams
- **Pros**: No server needed, secure, easy distribution
- **Cons**: Windows only, requires local installation

### 2. Web Application
- **Best for**: Large organizations, multi-user access
- **Pros**: Accessible from anywhere, centralized management
- **Cons**: Requires Windows server, more complex setup

### 3. Enterprise Distribution
- **Best for**: Corporate environments
- **Pros**: Centralized deployment, group policy integration
- **Cons**: Requires IT infrastructure

## 📦 Distribution

### Creating Installers
```bash
# Windows (.exe)
npm run electron:build

# macOS (.dmg)
npm run electron:build -- --mac

# Linux (.AppImage)
npm run electron:build -- --linux
```

### GitHub Actions (Automated Builds)
```yaml
# .github/workflows/build.yml
name: Build Desktop App
on: [push, pull_request]
jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm install
      - run: npm run electron:build
      - uses: actions/upload-artifact@v3
        with:
          name: desktop-app
          path: electron-dist/
```

## 🔒 Security

### Desktop App Security
- ✅ No network exposure
- ✅ Local PowerShell execution
- ✅ User controls their own data
- ✅ No server vulnerabilities
- ✅ Secure authentication through Microsoft 365

### Best Practices
- Keep PowerShell modules updated
- Use strong Microsoft 365 credentials
- Regularly update the application
- Monitor PowerShell execution logs

## 🐛 Troubleshooting

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

### Getting Help
1. Check the [main README.md](../README.md) for general information
2. Review [DEPLOYMENT.md](../DEPLOYMENT.md) for deployment options
3. Open an issue on GitHub for bugs or feature requests

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/samerth-ccp/placesmanager/issues)
- **Documentation**: [Full documentation](../README.md)
- **Deployment Guide**: [Deployment options](../DEPLOYMENT.md)

---

**Places Manager Desktop** - Manage Microsoft Places with the power of PowerShell in a beautiful desktop application. 
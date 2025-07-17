# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Node.js 20 LTS
RUN powershell -Command `
    Invoke-WebRequest -Uri https://nodejs.org/dist/v20.14.0/node-v20.14.0-x64.msi -OutFile node.msi; `
    Start-Process msiexec.exe -Wait -ArgumentList '/I node.msi /quiet'; `
    Remove-Item node.msi

# Install PowerShell 7
RUN powershell -Command `
    Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.msi -OutFile pwsh.msi; `
    Start-Process msiexec.exe -Wait -ArgumentList '/I pwsh.msi /quiet'; `
    Remove-Item pwsh.msi

# Set working directory
WORKDIR /app

# Copy package files and install dependencies first (for better caching)
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the frontend and backend
RUN npm run build

# Install required PowerShell modules (for Microsoft Places)
RUN pwsh -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber; Install-Module -Name Microsoft.Graph.Places -Force -AllowClobber; Install-Module -Name Microsoft.Places.PowerShell -Force -AllowClobber;"

# Expose the port the app runs on
EXPOSE 5000

# Start the app
CMD ["npm", "run", "start"] 
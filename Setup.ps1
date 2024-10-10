# Setup script for Elm Android App development environment

# Function to check if a command exists
function Test-Command($command) {
    try { Get-Command $command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

# Function to install a tool using winget
function Install-Tool($name, $id) {
    if (-not (Test-Command $name)) {
        Write-Host "$name is not installed. Installing..."
        winget install -e --id $id
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Failed to install $name. Please install it manually." -ForegroundColor Red
            exit 1
        }
        Write-Host "$name installed successfully." -ForegroundColor Green
    } else {
        Write-Host "$name is already installed." -ForegroundColor Green
    }
}

# Check and install Node.js
Install-Tool "node" "OpenJS.NodeJS"

# Check and install Java Development Kit (JDK)
Install-Tool "java" "Microsoft.OpenJDK.17"

# Check and install Gradle
Install-Tool "gradle" "Gradle.Gradle"

# Install Android command-line tools
$androidSdkRoot = "C:\tools\android-sdk"
$cmdlineToolsPath = "$androidSdkRoot\cmdline-tools\latest"

if (-not (Test-Path $cmdlineToolsPath)) {
    Write-Host "Android command-line tools not found. Installing..."
    $tempFile = "$env:TEMP\commandlinetools-win-latest.zip"
    Invoke-WebRequest -Uri "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip" -OutFile $tempFile
    Expand-Archive -Path $tempFile -DestinationPath "$androidSdkRoot\cmdline-tools" -Force
    Move-Item "$androidSdkRoot\cmdline-tools\cmdline-tools" "$androidSdkRoot\cmdline-tools\latest"
    Remove-Item $tempFile
    Write-Host "Android command-line tools installed successfully." -ForegroundColor Green

    # Set ANDROID_HOME environment variable
    [System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $androidSdkRoot, [System.EnvironmentVariableTarget]::User)
    $env:ANDROID_HOME = $androidSdkRoot

    # Add Android tools to PATH
    $path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
    $newPaths = @(
        "$androidSdkRoot\cmdline-tools\latest\bin",
        "$androidSdkRoot\platform-tools"
    )
    $updatedPath = ($path.Split(';') + $newPaths) -join ';'
    [System.Environment]::SetEnvironmentVariable("Path", $updatedPath, [System.EnvironmentVariableTarget]::User)
    $env:Path = $updatedPath

    # Install necessary Android SDK components
    Write-Host "Installing necessary Android SDK components..."
    & "$cmdlineToolsPath\bin\sdkmanager.bat" "platform-tools" "platforms;android-31" "build-tools;31.0.0"
} else {
    Write-Host "Android command-line tools are already installed." -ForegroundColor Green
}

# Install global npm packages
$npmPackages = @("elm", "elm-format", "elm-test", "cordova")
foreach ($package in $npmPackages) {
    if (-not (Test-Command $package)) {
        Write-Host "Installing $package globally..."
        npm install -g $package
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Failed to install $package. Please install it manually." -ForegroundColor Red
            exit 1
        }
        Write-Host "$package installed successfully." -ForegroundColor Green
    } else {
        Write-Host "$package is already installed." -ForegroundColor Green
    }
}

Write-Host "Setup complete! All necessary tools are installed." -ForegroundColor Green
# Setup script for Elm Android App development environment

# Function to check if a command exists
function Test-Command($command) {
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'stop'
    try { if (Get-Command $command) { return $true } }
    catch { return $false }
    finally { $ErrorActionPreference = $oldPreference }
}

# Function to install a package using winget
function Install-WithWinget($package) {
    Write-Host "Installing $package..."
    winget install --id $package --silent --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install $package. Please install it manually."
        exit 1
    }
}

# Check and install Git
if (-not (Test-Command "git")) {
    Install-WithWinget "Git.Git"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Check and install Node.js
if (-not (Test-Command "node")) {
    Install-WithWinget "OpenJS.NodeJS.LTS"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Check and install JDK
if (-not (Test-Command "java")) {
    Install-WithWinget "Microsoft.OpenJDK.17"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Check and install Gradle
if (-not (Test-Command "gradle")) {
    Install-WithWinget "Gradle.Gradle"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Install global npm packages
npm install -g elm elm-format elm-test cordova

# Install Android SDK
$androidSdkPath = "$env:LOCALAPPDATA\Android\Sdk"
if (-not (Test-Path $androidSdkPath)) {
    Write-Host "Installing Android SDK..."
    $sdkManagerUrl = "https://dl.google.com/android/repository/commandlinetools-win-9477386_latest.zip"
    $sdkZipPath = "$env:TEMP\android-sdk.zip"
    Invoke-WebRequest -Uri $sdkManagerUrl -OutFile $sdkZipPath
    Expand-Archive -Path $sdkZipPath -DestinationPath $androidSdkPath
    Remove-Item $sdkZipPath
}

# Set ANDROID_HOME environment variable
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", $androidSdkPath, "User")
$env:ANDROID_HOME = $androidSdkPath

# Add Android SDK tools to PATH
$toolsPaths = @(
    "$androidSdkPath\tools",
    "$androidSdkPath\platform-tools",
    "$androidSdkPath\cmdline-tools\latest\bin"
)
foreach ($path in $toolsPaths) {
    if ($env:Path -notlike "*$path*") {
        [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$path", "User")
        $env:Path += ";$path"
    }
}

Write-Host "Setup complete! All necessary tools are installed." -ForegroundColor Green

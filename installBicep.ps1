[CmdletBinding()]
param ()

# Variables
$bicepFolder = "$env:USERPROFILE\.bicep"
$bicepShell = "%USERPROFILE%\.bicep"
$bicepExe = "$bicepFolder\bicep.exe"
$bicepUrl = 'https://github.com/Azure/bicep/releases/latest/download/bicep-win-x64.exe'

# Create the install folder
Write-Verbose -Message "Creating $bicepFolder"
$installDir = New-Item -ItemType Directory -Path $bicepFolder -Force
$installDir.Attributes += 'Hidden'

# Fetch the latest Bicep CLI binary
Write-Verbose -Message 'Downloading latest Bicep binary'
(New-Object Net.WebClient).DownloadFile($bicepUrl, $bicepExe)

# Add bicep to your PATH
Write-Verbose -Message 'Updating PATH variable'
$currentPath = (Get-Item -path "HKCU:\Environment" ).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
if (-not $currentPath.Contains($bicepShell)) { setx PATH ($currentPath + ";$bicepShell") }
if (-not $env:path.Contains($bicepFolder)) { $env:path += ";$bicepFolder" }

# Verify you can now access the 'bicep' command.
bicep --version
# Done!

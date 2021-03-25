[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true)]
    [String]
    $TemplateDescription,

    [Parameter()]
    [ValidateScript({Test-Path -Path $_ -PathType Container})]
    [String]
    $Path
)

# Retrieve all templates
Write-Verbose -Message 'Retrieving available Bicep Examples'
$templateJsonUrl = 'https://raw.githubusercontent.com/Azure/bicep/main/docs/examples/index.json'
$availableTemplates = Invoke-RestMethod -UseBasicParsing -Uri $templateJsonUrl -Verbose:$false

# Retrieve what is needed
Write-Verbose -Message "Verifying if $TemplateDescription exists in available templates"
if ($availableTemplates.description -contains $TemplateDescription)
{
    # Retrieve bicep file path
    $bicepFilePath = $availableTemplates.Where({$_.description -eq $TemplateDescription}).filepath

    # Build the URL to retrieve the content
    $bicepUrl = "https://raw.githubusercontent.com/Azure/bicep/main/docs/examples/$bicepFilePath"

    # Download bicep example
    Write-Verbose -Message "Downloading $bicepUrl"
    Invoke-WebRequest -UseBasicParsing -Uri $bicepUrl -OutFile "$Path\main.bicep" -Verbose:$false
}
else
{
    throw "No matching template was found for the given template description $TemplateDescription"
}
[CmdletBinding()]
param
(
    [Parameter()]
    [ValidateSet('All','101','201','301')]
    [String]
    $TemplateLevel = 'All',

    [Parameter()]
    [String]
    $Keyword
)

# Retrieve all templates
Write-Verbose -Message 'Retrieving available Bicep Examples'
$templateJsonUrl = 'https://raw.githubusercontent.com/Azure/bicep/main/docs/examples/index.json'
$availableTemplates = Invoke-RestMethod -UseBasicParsing -Uri $templateJsonUrl -Verbose:$false

# Retrieve what is needed
if ($TemplateLevel -ne 'All')
{
    $availableTemplates.Description.Where({$_.StartsWith($TemplateLevel) -and $_ -like "*$Keyword*"})
}
else
{
    $availableTemplates.Description.Where({$_ -like "*$Keyword*"})
}
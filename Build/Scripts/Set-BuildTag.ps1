Param(
    [string] $BuildNumber
)

Import-Module $PSScriptRoot\EnlistmentHelperFunctions.psm1
$buildVersion = Get-BuildVersion -BuildNumber $BuildNumber
git tag $buildVersion
git push --tags
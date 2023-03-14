Param(
    [Parameter(Mandatory = $false)]
    [string]$Owner = "aholstrup1",
    [Parameter(Mandatory = $false)]
    [string]$Repo = "AlAppExtensions",
    [Parameter(Mandatory = $false)]
    [string]$TargetBranch = "main",
    [Parameter(Mandatory = $false)]
    [string]$Token
)

Write-Host "Owner: $Owner"
Write-Host "Repo: $Repo"
Write-Host "TargetBranch: $TargetBranch"

# Setup Enlistment
$webClient = New-Object System.Net.WebClient
$webClient.CachePolicy = New-Object System.Net.Cache.RequestCachePolicy -argumentList ([System.Net.Cache.RequestCacheLevel]::NoCacheNoStore)
$webClient.Encoding = [System.Text.Encoding]::UTF8
Write-Host "Downloading GitHub Helper module"
$GitHubHelperPath = "$([System.IO.Path]::GetTempFileName()).psm1"
$webClient.DownloadFile('https://raw.githubusercontent.com/microsoft/AL-Go-Actions/preview/Github-Helper.psm1', $GitHubHelperPath)
Write-Host "Downloading AL-Go Helper script"
$ALGoHelperPath = "$([System.IO.Path]::GetTempFileName()).ps1"
$webClient.DownloadFile('https://raw.githubusercontent.com/microsoft/AL-Go-Actions/preview/AL-Go-Helper.ps1', $ALGoHelperPath)
Import-Module $GitHubHelperPath
. $ALGoHelperPath -local

$baseFolder = GetBaseFolder -folder $PSScriptRoot
DownloadAndImportBcContainerHelper -baseFolder $baseFolder

Import-Module $PSScriptRoot\EnlistmentHelperFunctions.psm1
Import-Module $PSScriptRoot\GuardingV2ExtensionsHelper.psm1

$latestBaseline = Get-LatestBaselineVersionFromArtifacts
$currentBaseline = Get-ConfigValueFromKey -Key "baselineVersion" -ConfigType "BuildConfig" 

if ([System.Version] $latestBaseline -gt [System.Version] $currentBaseline) {
    Write-Host "Updating baseline version from $currentBaseline to $latestBaseline"

    Set-ConfigValueFromKey -Key "baselineVersion" -Value $latestBaseline -ConfigType "BuildConfig"

    $currentDate = (Get-Date).ToUniversalTime().ToString("yyMMddHHmm")
    $BranchName = "private/UpdateBaselineVersion-$latestBaseline-$currentDate"
    git checkout -b $BranchName | Out-Null
    git push --set-upstream origin $BranchName

    New-GitHubPullRequest -Title "Update baseline version to $latestBaseline" -Owner $Owner -Repo $Repo -Head $BranchName -Base $TargetBranch -Token $Token
} else {
    Write-Host "Current baseline version is already up to date"
}
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

Write-Host "Owner: $Owner" -ForegroundColor Magenta
Write-Host "Repo: $Repo" -ForegroundColor Magenta
Write-Host "TargetBranch: $TargetBranch" -ForegroundColor Magenta

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

Write-Host "LatestBaseline: $latestBaseline" -ForegroundColor Magenta
Write-Host "CurrentBaseline: $currentBaseline" -ForegroundColor Magenta

if ([System.Version] $latestBaseline -ge [System.Version] $currentBaseline) { #TODO: Fix ge
    Write-Host "Updating baseline version from $currentBaseline to $latestBaseline" -ForegroundColor Green

    Set-ConfigValueFromKey -Key "baselineVersion" -Value $latestBaseline -ConfigType "BuildConfig"

    $currentDate = (Get-Date).ToUniversalTime().ToString("yyMMddHHmm")
    $BranchName = "private/UpdateBaselineVersion-$latestBaseline-$currentDate"
    git checkout -b $BranchName | Out-Null
    git push --set-upstream origin $BranchName

    New-GitHubPullRequest -Title "Update baseline version to $latestBaseline" -Head $BranchName -Base $TargetBranch  -Token $Token
}


# This function creates a pull request in Github with the current branch
function New-GitHubPullRequest {
    param(
        [string]$Owner,
        [string]$Repo,
        [string]$Title,
        [string]$Body,
        [string]$Head,
        [string]$Base,
        [string]$Token
    )

    $uri = "https://api.github.com/repos/$Owner/$Repo/pulls"
    $headers = @{
        "Authorization" = "token $Token"
        "Content-Type"  = "application/json"
    }

    $body = @{
        "title" = $Title
        "body"  = $Body
        "head"  = $Head
        "base"  = $Base
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $body
}

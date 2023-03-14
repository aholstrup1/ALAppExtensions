Param(
    [Parameter(Mandatory = $true)]
    [string]$Owner = "aholstrup1",
    [Parameter(Mandatory = $true)]
    [string]$Repo = "AlAppExtensions",
    [Parameter(Mandatory = $true)]
    [string]$TargetBranch = "main",
    [Parameter(Mandatory = $true)]
    [string]$Token
)

Write-Host "Owner: $Owner" -ForegroundColor Magenta
Write-Host "Repo: $Repo" -ForegroundColor Magenta
Write-Host "TargetBranch: $TargetBranch" -ForegroundColor Magenta

Import-Module $PSScriptRoot\EnlistmentHelperFunctions.psm1
Import-Module $PSScriptRoot\GuardingV2ExtensionsHelper.psm1

$latestBaseline = Get-LatestBaselineVersionFromArtifacts
$currentBaseline = Get-ConfigValueFromKey -Key "baselineVersion" -ConfigType "BuildConfig" 

Write-Host "LatestBaseline: $latestBaseline" -ForegroundColor Magenta
Write-Host "CurrentBaseline: $currentBaseline" -ForegroundColor Magenta

if ([System.Version] $latestBaseline -gt [System.Version] $currentBaseline) {
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

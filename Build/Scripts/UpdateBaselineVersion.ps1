Param(
    [Parameter(Mandatory = $false)]
    [string]$Owner,
    [Parameter(Mandatory = $false)]
    [string]$Repo,
    [Parameter(Mandatory = $false)]
    [string]$TargetBranch,
    [Parameter(Mandatory = $false)]
    [string]$Actor,
    [Parameter(Mandatory = $false)]
    [string]$Token
)

Import-Module $PSScriptRoot\EnlistmentHelperFunctions.psm1
Import-Module $PSScriptRoot\GuardingV2ExtensionsHelper.psm1
Import-Module $PSScriptRoot\AutomatedSubmission.psm1
Install-Module -Name BcContainerHelper

$latestBaseline = Get-LatestBaselineVersionFromArtifacts
$currentBaseline = Get-ConfigValueFromKey -Key "baselineVersion" -ConfigType "BuildConfig" 

if ([System.Version] $latestBaseline -gt [System.Version] $currentBaseline) {
    Write-Host "Updating baseline version from $currentBaseline to $latestBaseline"
    Set-ConfigValueFromKey -Key "baselineVersion" -Value $latestBaseline -ConfigType "BuildConfig"

    # Create branch and push changes
    Set-GitConfig -Actor $Actor -Token $Token
    $BranchName = New-AutoSubmissionTopicBranch -SubFolder "UpdateBaselineVersion"
    $title = "Update baseline version to $latestBaseline"
    Push-AutoSubmissionChange -BranchName $BranchName -Files @("Build/BuildConfig.json") -CommitMessage $title

    # Create PR
    $Token | invoke-gh auth login --with-token
    gh pr create --fill --head $Head --base $Base --repo $Repo --label "infrastructure"
} else {
    Write-Host "Current baseline version is already up to date"
}
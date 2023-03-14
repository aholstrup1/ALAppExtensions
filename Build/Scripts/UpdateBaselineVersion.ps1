Param(
    [Parameter(Mandatory = $false)]
    [string]$Owner = "aholstrup1",
    [Parameter(Mandatory = $false)]
    [string]$Repo = "AlAppExtensions",
    [Parameter(Mandatory = $false)]
    [string]$TargetBranch = "main",
    [Parameter(Mandatory = $false)]
    [string]$Actor,
    [Parameter(Mandatory = $false)]
    [string]$Token
)

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
# End Enlistment

function Push-AutoSubmissionChange
(
    [Parameter(Mandatory=$true)]
    [string] $BranchName,
    [string[]] $Files,
    [string] $CommitMessage
) 
{
    invoke-git add $Files
    invoke-git commit -m $commitMessage
    invoke-git push -u origin $BranchName
}

function Set-GitConfig
(
    [Parameter(Mandatory=$true)]
    [string] $Actor,
    [Parameter(Mandatory=$true)]
    [string] $Token
)
{
    invoke-git config --global user.name $Actor
    invoke-git config --global user.email "$($Actor)@users.noreply.github.com"
    invoke-git config --global hub.protocol https
    invoke-git config --global core.autocrlf false
}

function New-AutoSubmissionTopicBranch
{
    param
    (
        [Parameter(Mandatory=$true, ParameterSetName = 'BranchName')]
        [string] $BranchName,
        [Parameter(Mandatory=$true, ParameterSetName = 'SubFolder')]
        [string] $SubFolder
    )

    if($PsCmdlet.ParameterSetName -eq "SubFolder") {
        $currentDate = (Get-Date).ToUniversalTime().ToString("yyMMddHHmm")
        $BranchName = "private/$SubFolder/$latestBaseline-$currentDate"
    }
    
    invoke-git checkout -b $BranchName | Out-Null

    return $BranchName
}

$baseFolder = GetBaseFolder -folder $PSScriptRoot
DownloadAndImportBcContainerHelper -baseFolder $baseFolder

Import-Module $PSScriptRoot\EnlistmentHelperFunctions.psm1
Import-Module $PSScriptRoot\GuardingV2ExtensionsHelper.psm1

$latestBaseline = Get-LatestBaselineVersionFromArtifacts
$currentBaseline = Get-ConfigValueFromKey -Key "baselineVersion" -ConfigType "BuildConfig" 

if ([System.Version] $latestBaseline -gt [System.Version] $currentBaseline) {
    Write-Host "Updating baseline version from $currentBaseline to $latestBaseline"

    Set-ConfigValueFromKey -Key "baselineVersion" -Value $latestBaseline -ConfigType "BuildConfig"

    Set-GitConfig -Actor $Actor -Token $Token
    $BranchName = New-AutoSubmissionTopicBranch -SubFolder "UpdateBaselineVersion"
    Push-AutoSubmissionChange -BranchName $BranchName -Files @("Build/BuildConfig.json") -CommitMessage $title
    New-GitHubPullRequest -Title $title -Owner $Owner -Repo $Repo -Head $BranchName -Base $TargetBranch -Token $Token
} else {
    Write-Host "Current baseline version is already up to date"
}
<#
.Synopsis
    Set the git config for the current actor
.Parameter Actor
    The actor to set the git config for
.Parameter Token
    The token to use for the git config
#>
function Set-GitConfig
(
    [Parameter(Mandatory=$true)]
    [string] $Actor,
    [Parameter(Mandatory=$true)]
    [string] $Token
)
{
    git config --global user.name $Actor
    git config --global user.email "$($Actor)@users.noreply.github.com"
    git config --global hub.protocol https
    git config --global core.autocrlf false
}

<#
.Synopsis 
    Stages files for commit and pushes them to the specified branch
.Parameter BranchName
    The name of the branch to push to
.Parameter Files
    The files to stage for commit
.Parameter CommitMessage
    The commit message to use
#>
function Push-AutoSubmissionChange
(
    [Parameter(Mandatory=$true)]
    [string] $BranchName,
    [string[]] $Files,
    [string] $CommitMessage
) 
{
    git add $Files
    git commit -m $commitMessage
    git push -u origin $BranchName
}

<#
.Synopsis
    Creates a new branch for an automated submission
    If a subfolder is specified, the branch name will be in the format private/<subfolder>/<baselineVersion>-<currentDate>
    If a branch name is specified, the branch name will be used as is
.Parameter BranchName
    The name of the branch to create
.Parameter SubFolder
    The subfolder to use in the branch name
#>
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
    
    git checkout -b $BranchName | Out-Null

    return $BranchName
}

Export-ModuleMember -Function *-*
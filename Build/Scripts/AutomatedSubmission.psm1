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

    Write-Host "Uri: $uri"
    Write-Host "Body $body"

    Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $body
}

Export-ModuleMember -Function *-*
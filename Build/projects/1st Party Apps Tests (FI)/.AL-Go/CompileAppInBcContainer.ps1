Param(
    [Hashtable] $parameters
)

$scriptPath = Join-Path $PSScriptRoot "../../../scripts/CompileAppInBcContainer.ps1" -Resolve
$projectFolder = Join-Path $PSScriptRoot "../../1st Party Apps Tests (FI)"

. $scriptPath -parameters $parameters -currentProjectFolder $projectFolder
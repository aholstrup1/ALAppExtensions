Param(
    [Hashtable] $parameters
)

$scriptPath = Join-Path $PSScriptRoot "../../../scripts/CompileAppInBcContainer.ps1" -Resolve
$projectFolder = Join-Path $PSScriptRoot "../../1st Party Apps Tests (GB)"

. $scriptPath -parameters $parameters -currentProjectFolder $projectFolder
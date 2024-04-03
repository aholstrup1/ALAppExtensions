Param(
    [string] $appType,
    [ref] $compilationParams
)

$scriptPath = Join-Path $PSScriptRoot "../../../scripts/PreCompileApp.ps1" -Resolve
$projectFolder = Join-Path $PSScriptRoot "../../1st Party Apps Tests (NO)"

. $scriptPath -parameters $compilationParams -currentProjectFolder $projectFolder -appType $appType
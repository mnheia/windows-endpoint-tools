<#
.SYNOPSIS
    Copy new and newer files with robocopy; do not delete destination files.

.NOTES
    Author: mnheia
    Copyright: (c) 2026 mnheia
    Repository: https://github.com/mnheia/windows-endpoint-tools
    License: GPL-3.0 (see LICENSE)
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$Destination
)
if (-not (Test-Path -LiteralPath $Source -PathType Container)) { throw "Missing source: $Source" }
if ($PSCmdlet.ShouldProcess($Destination, "Sync from $Source")) {
    New-Item -Path $Destination -ItemType Directory -Force | Out-Null
    & robocopy.exe $Source $Destination /E /XO /R:1 /W:1 /NP
    if ($LASTEXITCODE -ge 8) { throw "Robocopy failed with exit code $LASTEXITCODE" }
}

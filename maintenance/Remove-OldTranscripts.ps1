<#
.SYNOPSIS
    Remove old PowerShell transcript files in a designated transcript directory.

.NOTES
    Author: mnheia
    Copyright: (c) 2026 mnheia
    Repository: https://github.com/mnheia/windows-endpoint-tools
    License: GPL-3.0 (see LICENSE)
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$Path,
    [int]$RetentionDays = 180,
    [switch]$Delete
)
$full = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).ProviderPath.TrimEnd('\')
if ($full -match '^[A-Za-z]:$' -or $full -match '^[A-Za-z]:\\Windows$') {
    throw 'Choose a dedicated transcript directory, not a system directory.'
}
$files = Get-ChildItem -LiteralPath $full -Recurse -File -Filter 'PowerShell_transcript*.txt' |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$RetentionDays) }
foreach ($file in $files) {
    if ($Delete) {
        if ($PSCmdlet.ShouldProcess($file.FullName, 'Delete old transcript')) {
            Remove-Item -LiteralPath $file.FullName -Force -ErrorAction Stop
        }
    } else { Write-Host "Would delete: $($file.FullName)" }
}

# Deploy a file and save a timestamped backup if the destination already exists.
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$Destination
)
if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) { throw "Missing source: $Source" }
if ((Test-Path -LiteralPath $Destination) -and
    (Get-FileHash -LiteralPath $Source).Hash -eq (Get-FileHash -LiteralPath $Destination).Hash) {
    Write-Host 'Destination is already current.'; return
}
if ($PSCmdlet.ShouldProcess($Destination, "Copy $Source")) {
    $parent = Split-Path -Path $Destination -Parent
    if ($parent) { New-Item -Path $parent -ItemType Directory -Force | Out-Null }
    if (Test-Path -LiteralPath $Destination) {
        Copy-Item -LiteralPath $Destination -Destination "$Destination.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    }
    Copy-Item -LiteralPath $Source -Destination $Destination -Force -ErrorAction Stop
}

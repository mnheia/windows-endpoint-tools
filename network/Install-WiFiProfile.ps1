<#
.SYNOPSIS
    Import an XML wireless network profile supplied by the administrator.

.NOTES
    Author: mnheia
    Copyright: (c) 2026 mnheia
    Repository: https://github.com/mnheia/windows-endpoint-tools
    License: GPL-3.0 (see LICENSE)
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$XmlPath,
    [ValidateSet('AllUsers','CurrentUser')][string]$Scope = 'CurrentUser'
)
$profile = (Resolve-Path -LiteralPath $XmlPath -ErrorAction Stop).ProviderPath
$null = [xml](Get-Content -LiteralPath $profile -Raw)
$user = if ($Scope -eq 'AllUsers') { 'all' } else { 'current' }
if ($PSCmdlet.ShouldProcess($Scope, "Install Wi-Fi profile $profile")) {
    & netsh.exe wlan add profile "filename=$profile" "user=$user"
    if ($LASTEXITCODE -ne 0) { throw 'Wi-Fi profile installation failed.' }
}

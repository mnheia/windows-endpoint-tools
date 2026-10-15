# Import an XML wireless network profile supplied by the administrator.
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

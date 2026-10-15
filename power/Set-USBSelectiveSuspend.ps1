# Enable or disable USB selective suspend for the active power plan.
[CmdletBinding(SupportsShouldProcess)]
param([ValidateSet('Enable','Disable')][string]$Mode = 'Disable')
$group = '2a737441-1930-4402-8d77-b2bebba308a3'
$setting = '48e6b7a6-50f5-4782-a5d4-53bb8f07e226'
$value = if ($Mode -eq 'Enable') { '1' } else { '0' }
if ($PSCmdlet.ShouldProcess('Active power plan', "$Mode USB selective suspend")) {
    & powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT $group $setting $value
    if ($LASTEXITCODE -ne 0) { throw 'powercfg AC operation failed.' }
    & powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT $group $setting $value
    if ($LASTEXITCODE -ne 0) { throw 'powercfg DC operation failed.' }
    & powercfg.exe /SETACTIVE SCHEME_CURRENT
    if ($LASTEXITCODE -ne 0) { throw 'Could not activate power settings.' }
}

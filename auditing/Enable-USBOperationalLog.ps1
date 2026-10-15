# Enable Windows DriverFrameworks operational event logging.
[CmdletBinding(SupportsShouldProcess)]
param()
$log = 'Microsoft-Windows-DriverFrameworks-UserMode/Operational'
if ((Get-WinEvent -ListLog $log).IsEnabled) { Write-Host 'Logging is already enabled.'; return }
if ($PSCmdlet.ShouldProcess($log, 'Enable event logging')) {
    & wevtutil.exe sl $log /e:true
    if ($LASTEXITCODE -ne 0) { throw 'Could not enable the log.' }
}

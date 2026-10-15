# Configure Large Send Offload on selected network adapters.
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string[]]$Name,
    [ValidateSet('Enable','Disable')][string]$Mode = 'Disable'
)
foreach ($adapter in $Name) {
    if ($PSCmdlet.ShouldProcess($adapter, "$Mode Large Send Offload")) {
        if ($Mode -eq 'Disable') { Disable-NetAdapterLso -Name $adapter -NoRestart -ErrorAction Stop }
        else { Enable-NetAdapterLso -Name $adapter -NoRestart -ErrorAction Stop }
    }
}

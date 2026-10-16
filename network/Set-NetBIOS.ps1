<#
.SYNOPSIS
    Enable, disable, or use DHCP defaults for NetBIOS over TCP/IP.

.NOTES
    Author: mnheia
    Copyright: (c) 2026 mnheia
    Repository: https://github.com/mnheia/windows-endpoint-tools
    License: GPL-3.0 (see LICENSE)
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][ValidateSet('Enable','Disable','DHCP')][string]$Mode,
    [string]$AdapterDescription = '*'
)
$options = @{ Enable=1; Disable=2; DHCP=0 }
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter 'IPEnabled=True' |
    Where-Object { $_.Description -like $AdapterDescription } |
    ForEach-Object {
        if ($PSCmdlet.ShouldProcess($_.Description, "NetBIOS: $Mode")) {
            $result = Invoke-CimMethod -InputObject $_ -MethodName SetTcpipNetbios -Arguments @{
                TcpipNetbiosOptions = [uint32]$options[$Mode]
            }
            if ($result.ReturnValue -notin 0,1) { throw "Failed: $($_.Description) ($($result.ReturnValue))" }
        }
    }

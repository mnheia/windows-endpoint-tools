Copyright (c) 2026, Mnheia <mnheia@gmail.com>

# windows-endpoint-tools

Straightforward PowerShell scripts for Windows desktop configuration, deployment and maintenance.

## Scripts

- `network/Set-NetBIOS.ps1` — enable, disable or follow DHCP NetBIOS configuration.
- `network/Set-TcpAutoTuning.ps1` — change receive auto-tuning and optional heuristics.
- `network/Set-NetAdapterLSO.ps1` — enable or disable Large Send Offload on named adapters.
- `network/Install-WiFiProfile.ps1` — install a supplied Wi-Fi XML profile.
- `localization/Set-RegionalSettings.ps1` — SI/DE/BE user culture and home location; optional language list and system locale.
- `power/Set-USBSelectiveSuspend.ps1` — USB power saving settings.
- `auditing/Enable-USBOperationalLog.ps1` — enable operational USB/DriverFrameworks event log.
- `deployment/Copy-ConfigurationFile.ps1` — copy a file, backing up its previous version.
- `deployment/Sync-NetworkDirectory.ps1` — non-deleting directory copy using robocopy.
- `maintenance/Remove-OldTranscripts.ps1` — retention for PowerShell transcript files.

```powershell
.\network\Set-NetBIOS.ps1 -Mode Disable -WhatIf
.\network\Set-NetAdapterLSO.ps1 -Name 'Ethernet' -Mode Disable -WhatIf
.\localization\Set-RegionalSettings.ps1 -Region SI
.\deployment\Sync-NetworkDirectory.ps1 -Source '\\fileserver\config' -Destination 'C:\Config'
.\maintenance\Remove-OldTranscripts.ps1 -Path 'C:\Logs\Transcripts' -RetentionDays 180
```

Run with Windows PowerShell 5.1 as administrator when changing system-wide settings. Most changes support standard `-WhatIf` to preview operations. Transcript deletion additionally requires `-Delete`.

## Bugs

Please report issues at https://github.com/mnheia/windows-endpoint-tools/issues

## License

GPL-3.0; see `LICENSE`.

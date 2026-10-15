# Configure Windows TCP receive-window auto-tuning.
[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('normal','disabled','restricted','highlyrestricted')][string]$Level = 'normal',
    [switch]$DisableHeuristics
)
if ($PSCmdlet.ShouldProcess('TCP stack', "Set auto-tuning to $Level")) {
    & netsh.exe interface tcp set global "autotuninglevel=$Level"
    if ($LASTEXITCODE -ne 0) { throw 'Unable to set auto-tuning.' }
    if ($DisableHeuristics) {
        & netsh.exe interface tcp set heuristics disabled
        if ($LASTEXITCODE -ne 0) { throw 'Unable to disable TCP heuristics.' }
    }
}

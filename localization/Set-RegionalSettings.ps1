# Set regional preferences for current user (Slovenia, Germany or Belgium).
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][ValidateSet('SI','DE','BE')][string]$Region,
    [switch]$SetUserLanguages,
    [switch]$SetSystemLocale
)
$locations = @{
    SI = @{Locale='sl-SI'; GeoId=212}
    DE = @{Locale='de-DE'; GeoId=94}
    BE = @{Locale='nl-BE'; GeoId=21}
}
$c = $locations[$Region]
if ($PSCmdlet.ShouldProcess('Current user', "Use $($c.Locale) regional settings")) {
    Set-Culture -CultureInfo $c.Locale
    Set-WinHomeLocation -GeoId $c.GeoId
    if ($SetUserLanguages) { Set-WinUserLanguageList -LanguageList $c.Locale -Force }
}
if ($SetSystemLocale -and $PSCmdlet.ShouldProcess('System locale', $c.Locale)) {
    Set-WinSystemLocale -SystemLocale $c.Locale
}

#Author Milan van Wingerden
#This script will check if TLS 1.2 is configurered.
#Check if registry's exist if exist create values.
#Works for this issue https://adminkb.com/hybrid-agent-exit-code-1603/

$registryPath1 = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727"
$registryPath2 = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
$registryPath3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727"
$registryPath4 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
$registryPath5 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
$registryPath6 = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"

$properties = @{
    "SystemDefaultTlsVersions" = 1
    "SchUseStrongCrypto" = 1
    "DisabledByDefault" = 0
    "Enabled" = 1
}

$registryPaths = @(
    $registryPath1,
    $registryPath2,
    $registryPath3,
    $registryPath4,
    $registryPath5,
    $registryPath6
)

foreach ($path in $registryPaths) {
    if (!(Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    foreach ($property in $properties.GetEnumerator()) {
        $name = $property.Key
        $value = $property.Value
        Set-ItemProperty -Path $path -Name $name -Value $value -Force
    }
}
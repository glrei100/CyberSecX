$registryPath = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$installedSoftware = Get-ItemProperty $registryPath | Where-Object { $_.DisplayName -ne $null }

$installedSoftware | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    ConvertTo-Markdown |
    Out-File -FilePath "$env:USERPROFILE\Desktop\installed_software.md"
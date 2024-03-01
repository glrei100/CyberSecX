# Specify the number of days for considering a certificate expired
$expiredDays = 30

# Specify the number of days for considering a certificate old
$oldDays = 35

# Specify the number of days for considering a certificate unused
$unusedDays = 30

# Get all certificates from the Local Machine store
$localMachineCerts = Get-ChildItem -Path Cert:\LocalMachine\My

# Filter out expired, old, and unused certificates
$expiredCerts = $localMachineCerts | Where-Object { $_.NotAfter -lt (Get-Date).AddDays(-$expiredDays) }
$oldCerts = $localMachineCerts | Where-Object { $_.NotBefore -lt (Get-Date).AddDays(-$oldDays) }
$unusedCerts = $localMachineCerts | Where-Object { $_.NotAfter -lt (Get-Date).AddDays(-$unusedDays) }
$untrustedCerts = $localMachineCerts | Where-Object { $_.GetIntendedTargets().Length -eq 0 }

# Combine the filtered certificates into a single collection
$certsToDelete = $expiredCerts + $oldCerts + $unusedCerts + $untrustedCerts

# Get all certificates from the Current User store
$currentUserCerts = Get-ChildItem -Path Cert:\CurrentUser\My

# Filter out expired, old, and unused certificates
$currentUserExpiredCerts = $currentUserCerts | Where-Object { $_.NotAfter -lt (Get-Date).AddDays(-$expiredDays) }
$currentUserOldCerts = $currentUserCerts | Where-Object { $_.NotBefore -lt (Get-Date).AddDays(-$oldDays) }
$currentUserUnusedCerts = $currentUserCerts | Where-Object { $_.NotAfter -lt (Get-Date).AddDays(-$unusedDays) }
$currentUserUntrustedCerts = $currentUserCerts | Where-Object { $_.GetIntendedTargets().Length -eq 0 }

# Combine the filtered certificates into a single collection
$currentUserCertstoDelete = $currentUserExpiredCerts + $currentUserOldCerts + $currentUserUnusedCerts + $currentUserUntrustedCerts

# Delete the certificates from the Local Machine store
foreach ($cert in $certsToDelete) {
    Remove-Item -Path $cert.PSPath -Force -Confirm:$false
}

# Delete the certificates from the Current User store
foreach ($cert in $currentUserCertstoDelete) {
    Remove-Item -Path $cert.PSPath -Force -Confirm:$false
}

Write-Host "Untrusted, expired, old, and unused certificates have been deleted from both Local Machine and Current User stores."
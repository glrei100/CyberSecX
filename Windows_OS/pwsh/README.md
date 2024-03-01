# FLR_certs
- Find, List, Remove: untrusted, expired, old, and unused certificates for both local and user stores.
    This script will delete all certificates from both the Local Machine and Current User stores that are untrusted, expired, old, and unused. The script first retrieves all certificates from the Local Machine store and the Current User store using the Get-ChildItem cmdlet with the -Path Cert:\LocalMachine\My and Cert:\CurrentUser\My parameters, respectively.

    Then, it filters out the expired, old, and unused certificates from both stores using various Where-Object conditions. The conditions check for certificates with NotAfter dates earlier than the specified number of days ago (to consider them expired), NotBefore dates earlier than the specified number of days ago (to consider them old), and NotAfter dates earlier than the specified number of days ago (to consider them unused). Additionally, it filters out the untrusted certificates by checking if the GetIntendedTargets() method returns an empty array (indicating no intended targets, which usually means the certificate is untrusted).

    Finally, it combines the filtered certificates from both stores into separate collections and deletes them using the Remove-Item cmdlet

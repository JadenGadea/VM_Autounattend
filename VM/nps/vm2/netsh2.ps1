# hardcoded credentials.
$username = 'admin'
$password = ConvertTo-SecureString '123' -AsPlainText -Force

# credentialobject
$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

#Öppnar fildelning och nätverk.
$scriptBlock = {
    netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
    netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
}

Invoke-Command -VMName "win10-b" -Credential $credential -ScriptBlock $scriptBlock

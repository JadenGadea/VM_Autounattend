#Delar network & filer på win10-a

$username = 'admin'
$password = ConvertTo-SecureString '123' -AsPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

$scriptBlock = {
    netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
    netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
}
Invoke-Command -VMName "win10-a" -Credential $credential -ScriptBlock $scriptBlock

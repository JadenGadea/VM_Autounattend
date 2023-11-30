$username = 'admin'
$password = ConvertTo-SecureString '123' -AsPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential ($username, $password)

Invoke-Command -VMName "win10-b" -Credential $credential -ScriptBlock {
    # User 1
    $pass1 = ConvertTo-SecureString -String "123" -AsPlainText -Force
    New-LocalUser -Name "user1" -Password $pass1 -FullName "User One" -Description "Description for User One"

    # User 2
    $pass2 = ConvertTo-SecureString -String "123" -AsPlainText -Force
    New-LocalUser -Name "user2" -Password $pass2 -FullName "User Two" -Description "Description for User Two"
}

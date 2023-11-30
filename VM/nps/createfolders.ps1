#Skapar nödvändiga mappar och sedan filer efteråt, lite stökigt. Men loopar iaf genom mapparna.
#Sätter även permissions för mapparna.

$securePasswordA = ConvertTo-SecureString "123" -AsPlainText -Force
$credA = New-Object System.Management.Automation.PSCredential ("admin", $securePasswordA)

Invoke-Command -VMName "win10-a" -Credential $credA -ScriptBlock {
    $folders = @(
        'C:\Shared\Common',
        'C:\Shared\NonCommon',
        'C:\Shared\ReadOnly',
        'C:\Shared\ReadWrite'
    )

    foreach ($folder in $folders) {
        New-Item -Path $folder -Type Directory -Force
    }

    & icacls 'C:\Shared\Common' /grant 'user1:(RX)' 'user2:(RX)' # read and execute permission
    & icacls 'C:\Shared\NonCommon' /grant 'user1:(RX)' # read and execute permission
    & icacls 'C:\Shared\ReadOnly' /grant 'user1:(R)' # read permission
    & icacls 'C:\Shared\ReadWrite' /grant 'user1:(M)' 'user2:(M)' # modify permission

        $folders = @(
            'C:\Shared\Common',
            'C:\Shared\NonCommon',
            'C:\Shared\ReadOnly',
            'C:\Shared\ReadWrite'
        )
    
        foreach ($folder in $folders) {
            New-Item -Path $folder -Type Directory -Force
            New-Item -Path (Join-Path $folder "file.txt") -Type File -Force
        }
    
        & icacls 'C:\Shared\Common' /grant 'user1:(RX)' 'user2:(RX)' # read and execute permission
        & icacls 'C:\Shared\NonCommon' /grant 'user1:(RX)' # read and execute permission
        & icacls 'C:\Shared\ReadOnly' /grant 'user1:(R)' # read permission
        & icacls 'C:\Shared\ReadWrite' /grant 'user1:(M)' 'user2:(M)' # modify permission

    }
    



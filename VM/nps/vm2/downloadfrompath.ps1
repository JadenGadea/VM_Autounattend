
#Många av raderna nedan är if else statements för felsökning. Hade lite problem här.

#hc creds för win10-b user2
$securePasswordB = ConvertTo-SecureString "123" -AsPlainText -Force
$credB = New-Object System.Management.Automation.PSCredential ("user2", $securePasswordB)

#hc creds för admin på win10-a fö
$securePasswordA = ConvertTo-SecureString "123" -AsPlainText -Force
$credA = New-Object System.Management.Automation.PSCredential ("admin", $securePasswordA)

#hämtar ip-adressen via vmname för win10-a som ska användas senare
Import-Module Hyper-V
$vmNameA = 'win10-a'
$ipAddress = Get-VM -Name $vmNameA | Get-VMNetworkAdapter | Select-Object -ExpandProperty IPAddresses
$ipv4AddressA = $ipAddress -match '^\d{1,3}(\.\d{1,3}){3}$'

#win10-a admin ger ger tillstånd till user2 för åtkomst till mapparna.
Invoke-Command -VMName "win10-a" -Credential $credA -ScriptBlock {
    & icacls 'C:\Shared\Common' /grant 'user2:(OI)(CI)M'
    & icacls 'C:\Shared\ReadWrite' /grant 'user2:(OI)(CI)M'
    #mapp får delas på nätverket, via smb
    New-SmbShare -Name "Shared" -Path "C:\Shared" -FullAccess "Everyone"
}

#win10-b loggar in som user2
Invoke-Command -VMName "win10-b" -Credential $credB -ScriptBlock {
    param($ipv4AddressA)
    #Skapar nätverksväg
    $networkPath = "\\$ipv4AddressA\Shared"
    #error handling.
    if (Test-Path $networkPath) {
        New-PSDrive -Name Z -PSProvider FileSystem -Root $networkPath -Persist

        Start-Sleep -Seconds 5

        $commonPath = "Z:\Common"
        $readWritePath = "Z:\ReadWrite"

        $desktopPath = "C:\Users\user2\Desktop"

        if (Test-Path $commonPath) {
            Copy-Item -Path "$commonPath\*" -Destination $desktopPath -Recurse
            Copy-Item -Path "$readWritePath\*" -Destination $desktopPath -Recurse

            try {
                Remove-Item -Path "$commonPath\*" -Recurse -Force -Verbose
                Remove-Item -Path "$readWritePath\*" -Recurse -Force -Verbose
            }
            catch {
                Write-Output "Error deleting files: $_"
            }
        }
        else {
            Write-Output "Drive Z is not available."
        }
    }
    else {
        Write-Output "Network path $networkPath is not accessible."
    }
} -ArgumentList $ipv4AddressA

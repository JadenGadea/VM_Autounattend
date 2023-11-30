#Master script, inväntar input från användare när vm's är klara.


& 'C:\VM\nps\vm.ps1'
& 'C:\VM\nps\vm2\vm2.ps1'

$proceed = $false
while (-not $proceed) {
    $userInput = Read-Host "Have windows finished on both computers? (Y/N)"
    if ($userInput -eq "Y") {
        $proceed = $true
    }
}

& 'C:\VM\nps\netsh.ps1'
& 'C:\VM\nps\vm2\netsh2.ps1'

& 'C:\VM\nps\createusers.ps1'
& 'C:\VM\nps\vm2\createusers2.ps1'

& 'C:\VM\nps\createfolders.ps1'
& 'C:\VM\nps\vm2\downloadfrompath.ps1'

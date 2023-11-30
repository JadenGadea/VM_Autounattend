# skapar variablar
$Name = "win10-a"
$VMPath = "C:/VM/OS/$Name"
$ISOPath = "C:/VM/ISO/windowsauto.iso"
$VHD = "C:/VM/Drives/$Name.vhdx"

# skapar vm mha variablarna
New-VM -Name $Name -MemoryStartupBytes 2GB -Path $VMPath -NewVHDPath $VHD -NewVHDSizeBytes 80GB -Generation 2 -SwitchName "VM Internal"
Add-VMDvdDrive -VMName $Name -Path $ISOPath

#lägger in variablarna för successiv boot order.
$vmDvdDrive = Get-VMDvdDrive -VMName $Name 
$vmHDD = Get-VMHardDiskDrive -VMName $Name
$vmNetAdapter = Get-VMNetworkAdapter -VMName $Name

#skapar boot order enligt nedan:
Set-VMFirmware $Name -BootOrder $vmDvdDrive, $vmHDD, $vmNetAdapter

Start-VM -Name $Name
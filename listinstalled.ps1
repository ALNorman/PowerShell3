$list=@()
$InstalledSoftwareKey="SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall"
$InstalledSoftware=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$pcname)
$RegistryKey=$InstalledSoftware.OpenSubKey($InstalledSoftwareKey)
$SubKeys=$RegistryKey.GetSubKeyNames()
Foreach ($key in $SubKeys){
$thisKey=$InstalledSoftwareKey+"\\"+$key
$thisSubKey=$InstalledSoftware.OpenSubKey($thisKey)
$obj = New-Object PSObject
$obj | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $pcname
$obj | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $($thisSubKey.GetValue("DisplayName"))
$obj | Add-Member -MemberType NoteProperty -Name "DisplayVersion" -Value $($thisSubKey.GetValue("DisplayVersion"))
$list += $obj
}
$list | where { $_.DisplayName } | select ComputerName, DisplayName, DisplayVersion | FT

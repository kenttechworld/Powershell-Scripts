$programList = New-Object System.Collections.Generic.List[string]

$programList.Add("VideoLAN.VLC")
$programList.Add("Notepad++.Notepad++")
$programList.Add("RevoUninstaller.RevoUninstaller")
$programList.Add("OBSProject.OBSStudio")
$programList.Add("Opera.Opera")
$programList.Add("Synology.Assistant")
$programList.Add("Synology.Assistant")
$programList.Add("Discord.Discord")
$programList.Add("Valve.Steam")
$programList.Add("WinDirStat.WinDirStat")

foreach ($item in $programList) {
    $input = Read-Host "install: $item (y/n)"
    if ($input -eq "y"){
        Write-Output "Installing $item 🍌"
        winget install --id $item --Source winget

    }

}


Write-Output "Removeing temp files" 
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue 
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Write-Output "################`n"

Write-Output "Cleaning Thumbnails"
Stop-Process -Name explorer -Force
$thumbCachePath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"
Get-ChildItem -Path $thumbCachePath -Include thumbcache*.db -Force | Remove-Item -Force
Start-Process explorer
Write-Output "################"
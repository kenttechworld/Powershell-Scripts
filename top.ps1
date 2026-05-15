while ($true) {
    Clear-Host
    Get-Process | Sort-Object CPU -Descending
    Start-Sleep(6)
}
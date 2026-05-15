$pingDest = Read-Host -Prompt "Host/IP to Ping"

while ($true) {
    Test-Connection -ComputerName $pingDest -Count 2 -BufferSize 256 | Out-File -FilePath $env:USERPROFILE\Downloads\PingLog.log -Append
    # Test-Connection -TargetName www.google.com -Traceroute
    # Test-Connection bing.com -TCPPort 443 -Detailed -Count 2
    Start-Sleep -Seconds 20  # Adjust the sleep interval as needed
}
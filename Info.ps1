Write-Host "Logs"
Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=(Get-Date).AddDays(-1)} |
    Group-Object -Property LevelDisplayName |
    Select-Object Name, Count |
    Format-Table -AutoSize

Write-Host "`n################`n"

Write-Host "REM use"
Get-CimInstance Win32_OperatingSystem |
    Select-Object @{Name="TotalVisibleMemory";Expression={"{0:N2} GB" -f ($_.TotalVisibleMemorySize/1MB)}},
                  @{Name="FreePhysicalMemory";Expression={"{0:N2} GB" -f ($_.FreePhysicalMemory/1MB)}} |
    Format-Table -AutoSize

Write-Host "`n################`n"

Write-Host "Running programs"
Get-CimInstance Win32_StartupCommand |
    Select-Object Name, Command, Location |
    Format-Table -AutoSize 

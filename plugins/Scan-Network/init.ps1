function Scan-Network()
{
  $onlineDevices = @()
  $offlineDevices = @()

  $ipRange = (1..255)

  $selectedIP = Get-NetIPAddress | Where-Object {$_.IPAddress -like "192.168.*" -or $_.IPAddress -like "10.*" -or $_.IPAddress -like "172.16.*"} | Sort-Object InterfaceIndex | Select-Object IPAddress | Out-GridView -Title "Select Network Adapter" -PassThru

  $splitIP = $selectedIP.IPAddress.Split(".")[0..2] -join "."

  $splitIP += "."
  
  foreach ($ip in $ipRange)
  {
    $testIP = $splitIP + $ip

    if (Test-Connection -Count 1 -BufferSize 2 -Quiet $testIP)
    {
      Write-Host "$($testIP) online" -ForegroundColor Green

      $onlineDevices += $testIP
    } else
    {
      Write-Host "$($testIP) offline" -ForegroundColor Red

      $offlineDevices += $testIP
    }
  }

  Write-Output "Online Devices: $($onlineDevices)"

  Write-Output "Offline Devices: $($offlineDevices)"
}

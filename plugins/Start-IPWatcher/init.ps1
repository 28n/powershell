function Start-IPWatcher
{
  param (
    [Parameter(Mandatory=$true)]
    [string]$IP,
    [Parameter(Mandatory=$true)]
    [int32]$Delay
  )

  # Check if the IP is a valid IP
  if ($IP -match "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
  {
    # Return true if the IP is valid
    Write-Host "IP $($IP) is valid" -ForegroundColor Gray
  } else
  {
    Write-Error "IP $($IP) is not valid"
    return
  }

  $status = ""

  $logFolder = $PSScriptRoot + "\Logs"

  # Check if the log folder exists
  if (Test-Path $logFolder)
  {
    # Return true if the log folder exists
    Write-Host "Log folder $($logFolder) exists" -ForegroundColor Gray
  } else
  {
    # Create the log folder
    New-Item -ItemType Directory -Path $logFolder
    Write-Host "Log folder $($logFolder) created" -ForegroundColor Gray
  }

  # Create the log file
  $logFile = $logFolder + "\IPWatcher_" + (Get-Date -Format "dd-MM-yyyy-HHmm") + "_" + $IP + ".log"

  # Check if the log file exists
  if (Test-Path $logFile)
  {
    # Return true if the log file exists
    Write-Host "Log file $($logFile) exists" -ForegroundColor Gray
  } else
  {
    # Create the log file
    New-Item -ItemType File -Path $logFile
    Write-Host "Log file $($logFile) created" -ForegroundColor Gray
  
    $logFileHeader =
    "#### IPWatcher ####",
    "Created by Sam Sierra",
    "Copyright (c) $(Get-Date -Format "yyyy") Sam Sierra",
    "Version 1.0",
    "",
    "",
    "",
    "#### Log ####",
    "",
    "$(Get-Date -Format "dd-MM-yyyy HH:mm:ss") - IPWatcher started",
    "IP: $($IP)",
    "Delay: $($Delay)",
    "",
    "##############################################",
    ""

    $logFileHeader | ForEach-Object {
      Add-Content -Path $logFile -Value $_
    }
  }

  Write-Host `n
  Write-Host "Starting IP watcher for $($IP) with a delay of $($Delay) seconds" -ForegroundColor Green
  Write-Host `n

  while ($true)
  {
    Write-Host "Checking $($IP)..." -ForegroundColor Yellow

    $ping = New-Object System.Net.NetworkInformation.Ping

    $pingReply = $ping.Send($IP, 1000)

    if ($pingReply.Status -eq "Success")
    {
      if ($status -ne "Success")
      {
        Write-Host "$(Get-Date -Format "dddd MM/dd/yyyy HH:mm"): $($IP) is now online ✓" -ForegroundColor Green
        $status = "Success"
        Add-Content $logFile "$(Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss"): $($IP) is now online ✓"
      }
      Write-Host "IP $($IP) is reachable" -ForegroundColor Green
    } else
    {
      if ($status -ne "Failure")
      {
        Write-Host "$(Get-Date -Format "dddd MM/dd/yyyy HH:mm"): $($IP) is now offline ×" -ForegroundColor Red
        $status = "Failure"
        Add-Content $logFile "$(Get-Date -Format "dddd MM/dd/yyyy HH:mm:ss"): $($IP) is now offline ×"
      }
      Write-Host "IP $($IP) is not reachable" -ForegroundColor Red
    }

    Start-Sleep -Seconds $Delay
  }
}

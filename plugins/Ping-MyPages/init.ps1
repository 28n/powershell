function Ping-MyPages()
{
  $DebugPreference = 'SilentlyContinue'

  $filePath = $PSScriptRoot + "\Ping-MyPages.txt"

  if (Test-Path $filePath)
  {
    $file = Get-Content $filePath
  } else
  {
    Write-Host "File not found: $filePath"
    return
  }

  $array = @()

  foreach ($line in $file)
  {
    $line = $line.Trim()

    if ($line -ne "" -and $line -notmatch "^#")
    {

      if ($line -notlike "http://*" -and $line -notlike "https://*")
      {
        $line = "http://" + $line
      }

      $array += $line
    }

  }

  foreach ($page in $array)
  {
    $caughtError = $false

    try
    {
      $ping = Invoke-WebRequest -Uri $page -Method Get -UseBasicParsing
      # $ping = Test-Connection -Delay 1 -Count 1 -Quiet $page
    } catch
    {
      Write-Host "Error pinging $page" -ForegroundColor Red
      $caughtError = $true
    } finally
    {
      if ($caughtError -eq $false)
      {
        Write-Host "Pinged $page" -ForegroundColor Green
        Write-Debug "Statuscode $($ping.StatusCode)"
      }
    }
  }
}

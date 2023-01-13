function PingMyPages()
{
  $DebugPreference = 'SilentlyContinue'

  $filePath = $PSScriptRoot + "\ping_mypages.txt"

  $file = Get-Content $filePath

  $array = @()

  foreach ($line in $file)
  {
    $array += $line
  }

  foreach ($page in $array)
  {
    try
    {
      $ping = Invoke-WebRequest -Uri $page -Method Get -UseBasicParsing
    } catch
    {
      Write-Host "Error pinging $page" -ForegroundColor Red
    } finally
    {
      Write-Host "Pinged $page" -ForegroundColor Green
      Write-Debug "Statuscode $($ping.StatusCode)"
    }
  }
}

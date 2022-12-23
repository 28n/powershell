function gitignore
{
  param (
    [switch]$help,
    [string]$type
  )

  $possibletypes = @(
    [pscustomobject]@{name = 'npm'; description = 'Minimal Gitignore that includes: package-locks and node_modules'}
  )

  $templates = @(
    [pscustomobject]@{name = 'npm'; content = 'n'}
  )

  if ($help -eq $true)
  {
    Write-Output "gitignore [type]"
    Write-Output "Possible Types:"

    $possibletypes | ForEach-Object {
      Write-Output "  $($_.name) - $($_.description)"
    }
    return
  }

  if ($type -ne '')
  {
    Write-Output $type
  } else
  {
    Write-Output 'No type specified'
  }
}

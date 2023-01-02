function gt
{
  param (
    [string]$target
  )

  $target = switch ($target)
  {
    'h' # home
    {
      '~'
    }
    'nv' # nvim config
    {
      $ENV:LOCALAPPDATA + '\nvim\'
    }
    'nvd' # nvim-data
    {
      $ENV:LOCALAPPDATA + '\nvim-data\'
    }
    'ps'
    {
      '~\.config\powershell\'
    }
    'psi'
    {
      'F:\projects\powershellinstaller\'
    }
    'pr'
    {
      'F:\projects'
    }
    default
    {
      ''
    }
  }

  if ($target -ne '')
  {
    Set-Location $target
  } else
  {
    Write-Host 'No Target specified'
  }
}

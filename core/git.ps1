function g ()
{
  param (
    [string]$command,
    [string]$arguments
  )

  $debug = $false

  $command = switch ($command)
  {
    's'
    { 
      'status'
    }
    'a'
    { 
      'add'
    }
    'p'
    {
      'push'
    }
    'c'
    {
      'cz'
    }
    'commit'
    {
      'cz'
    }
    default
    { 
      $command 
    }
  }
  $acceptsargs = switch ($command)
  {
    'cz'
    {
      $false
    }
    'c'
    {
      $false
    }
    'commit'
    {
      $false
    }
    default
    {
      $true 
    }
  }
  if ($command -ne '')
  {

    if ($command -eq 'add')
    {
      Write-Error "Add is not supported. Please use git add."
      return
    }


    if ($arguments -ne '')
    {
      if ($debug -eq $true)
      {
        Write-Host 'Writing CMD with Args'
      }

      if ($acceptsargs -eq $false)
      {
        Write-Host "Command does not accept Arguments, but it got:" $arguments
        return
      }

      git $command $arguments
    } else
    {
      if ($debug -eq $true)
      {
        Write-Host 'Writing CMD w/o Args'
      }
      git $command
    }
  } else
  {
    if ($debug -eq $true)
    {
      Write-Host 'Writing Git solo'
    }

    git
  }
  if ($debug -eq $true)
  {
    Write-Host 'Command:'
    Write-Host $command
    Write-Host 'Arguments:'
    Write-Host $arguments
  }
}

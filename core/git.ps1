function g ()
{
  param (
    [Parameter(Mandatory=$false, Position=0)]
    [String]$command,

    [Parameter(ValueFromRemainingArguments=$true)]
    [String[]]$arguments
  )

  $dev = $false

  $commands = @(
    [pscustomobject]@{
      command = "add";
      alias = "a";
      acceptsArgs = $true;
    }
    [pscustomobject]@{
      command = "commit";
      alias = "c";
      acceptsArgs = $false;
      override = "cz";
    }
    [pscustomobject]@{
      command = "status";
      alias = "s";
      acceptsArgs = $false;
    }
    [pscustomobject]@{
      command = "push";
      alias = "p";
      acceptsArgs = $false;
    }
    [pscustomobject]@{
      command = "pull";
      alias = "u";
      acceptsArgs = $false;
    }
    [pscustomobject]@{
      command = "diff";
      alias = "d";
      acceptsArgs = $false;
    }
  )

  $activeCommand = $commands | Where-Object { $_.command -eq $command -or $_.alias -eq $command }

  if ($dev -eq $true)
  {
    $activeCommand
  }

  if ($command -eq $null -or $command -eq '')
  {
    git
    return
  }

  if ($null -eq $activeCommand)
  {
    if ($dev -eq $true)
    {
      Write-Host "Normal Git execution"
    }
    git $command $arguments
    return
  }

  if ($activeCommand.acceptsArgs -eq $false -and $null -ne $arguments)
  {
    Write-Host "Command $command does not accept arguments"
    return
  }

  if ($activeCommand.acceptsArgs -eq $true -and $null -eq $arguments)
  {
    Write-Host "Command $command requires arguments"
    return
  }

  if ($null -ne $activeCommand.override)
  {
    if ($dev -eq $true)
    {
      Write-Host "Override execution"
    }
    git $activeCommand.override $arguments
    return
  }

  if ($dev -eq $true)
  {
    Write-Host "Executing command $command with arguments $arguments"
  }

  git $activeCommand.command $arguments

  if ($dev -eq $true)
  {
    Write-Host 'Command:' $command
    Write-Host 'Arguments:' $arguments
  }
}

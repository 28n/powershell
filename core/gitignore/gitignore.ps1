function gitignore
{
  param (
    [switch]$help,
    [switch]$show,
    [string]$type
  )

  $possibletypes = 
  "node",
  "rails"

  $helptexts = @(
    [pscustomobject]@{name = 'node'; description = 'Includes all possible files in and around the Node System. Mainly used to exclude node_modules and package-locks, but also for framework folders like .next'}
    [pscustomobject]@{name = 'rails'; description = 'Gitignore for popular Ruby Web Framework Rails. Excludes DBs, Logs, Secrets and more!'}
  )

  function showHelp()
  {
    Write-Output "gitignore [type]"
    Write-Output ""
    Write-Output "Possible Types:"

    $helptexts | ForEach-Object {
      Write-Output "  $($_.name) - $($_.description)"
    }

    Write-Output ""
    Write-Output "Possible Flags:"
    Write-Output "  -h, --help  Show help"
    Write-Output "  -s --show %template% Show Content of Template file"
  }

  if ($help -eq $true)
  {
    showHelp
    return
  }

  if ($show -eq $true)
  {
    if ($type -ne '')
    {
      if ($possibletypes -contains $type)
      {
        $template = Get-Content "$PSScriptRoot\templates\$type.txt"
        Write-Output $template
      }
    }
    return
  }

  if ($type -ne '')
  {
    if ($possibletypes -contains $type)
    {
      $fileexists = Test-Path ".gitignore"
      $gitexists = Test-Path ".git"

      if ($gitexists -eq $false)
      {
        Write-Output "No Git Repository found in this directory!"
        return
      }

      if ($fileexists -eq $true)
      {
        Write-Error "File .gitignore already exists!"
        return
      }
      $template = Get-Content $PSScriptRoot\templates\$type.txt
      $template | Out-File .gitignore
      Write-Output "Successfully created .gitignore with template: $type"
    } else
    {
      Write-Error "Type $type is not a valid type"
    }
  } else
  {
    showHelp
  }
}

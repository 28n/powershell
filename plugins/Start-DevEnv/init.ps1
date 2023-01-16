function Start-DevEnv
{
  param (
    [switch]$help,
    [switch]$nvim,
    [switch]$web,
    [switch]$vscode
  )

  if ($help)
  {
    Write-Host "Start-DevEnv [-nvim] [-web] [-vscode]"
    Write-Host "  -nvim: Start neovim in cwd"
    Write-Host "  -web: Start web browser"
    Write-Host "  -vscode: Start VS Code in cwd"
    return
  }

  $currentPath = Get-Location

  $webPages = @(
    "https://github.com/28n"
  )

  if ($nvim)
  {
    if (Get-Command nvim -ErrorAction SilentlyContinue)
    {
      wt -w 0 -d $currentPath nvim
    } else
    {
      Write-Error "Neovim is not installed"
    }
  }

  if ($web)
  {
    foreach ($webPage in $webPages)
    {
      Start-Process $webPage
    }
  }

  if ($vscode)
  {
    if (Get-Command Code -ErrorAction SilentlyContinue)
    {
      Start-Process "code"
    } else
    {
      Write-Error "VS Code is not installed"
    }
  }
}

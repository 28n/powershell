$ENV:STARSHIP_DISTRO = "者 Sierra "
Invoke-Expression (&starship init powershell)

$starshipConfigPath = Test-Path ~\.config\starship.toml

if ($starshipConfigPath -eq $false)
{
  Write-Output "The Starship config file does not exist. Please create one."
}

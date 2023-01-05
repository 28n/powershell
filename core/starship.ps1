$starshipConfigPath = Test-Path ~\.config\powershell\starship.toml

$ENV:STARSHIP_DISTRO = "者 Sierra "
$ENV:STARSHIP_CONFIG = "$HOME\.config\powershell\starship.toml"

Invoke-Expression (&starship init powershell)

if ($starshipConfigPath -eq $false)
{
  Write-Output "The Starship config file does not exist. Please create one."
}

Import-Module posh-git

function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'lambda.omp.json'
# oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression

Invoke-Expression (&starship init powershell)

$starshipConfigPath = Test-Path ~\.config\starship.toml


Import-Module -Name Terminal-Icons

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl-d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias Array

$aliasdata = @(
  [pscustomobject]@{name = 'vim'; command = 'nvim'}
  [pscustomobject]@{name = 'vi'; command = 'nvim'}
  [pscustomobject]@{name = 'g'; command = 'git'}
  [pscustomobject]@{name = 'll'; command = 'ls'}
  [pscustomobject]@{name = 'grep'; command = 'findstr'}
  [pscustomobject]@{name = 'tig'; command = 'C:\Program Files\Git\usr\bin\tig.exe'}
  [pscustomobject]@{name = 'less'; command = 'C:\Program Files\Git\usr\bin\less.exe'}
  [pscustomobject]@{name = 'n'; command = 'pnpm'}
  [pscustomobject]@{name = 'npm'; command = 'pnpm'}
)

$aliasdata | ForEach-Object {
  Set-Alias $_.name $_.command
}

# Set-Alias vim nvim
# Set-Alias vi nvim
# Set-Alias ll ls
# Set-Alias g git
# Set-Alias grep findstr
# Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
# Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$runsAsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function admin () {
  if ($runsAsAdmin) {
    # start powershell and echo hello world
    Write-Host "You are already running as Administrator"
    return
  } else {
    Start-Process wt.exe -Verb RunAs
  }
}

function isAdmin () {
  if ($runsAsAdmin) {
    Write-Host "You are running as admin"
  } else {
    Write-Host "You are not running as admin"
  }
}

function author () {
    Start-Process "https://www.samsierra.de"
}

function tab () {
    wt -w 0 nt
}

function cwdtab () {
    wt -w 0 nt -d .
}

# CLS
cls

if ($starshipConfigPath -eq $false) {
  echo "The Starship config file does not exist. Please create one."
}

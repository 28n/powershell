$aliasdata = @(
  [pscustomobject]@{name = 'vim'; command = 'nvim'}
  [pscustomobject]@{name = 'vi'; command = 'nvim'}
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

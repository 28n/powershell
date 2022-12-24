# POWERSHELL CONFIG
# Copyright 2022, Sam Sierra
# https://www.samsierra.de
# This work is licensed under the GNU General Public License v3.0
# For more, feel free to visit my Github: https://github.com/28n

# IMPORTANT: Paths can only be seperated using Underscores
$coremodules = 
"terminal_icons",
"psreadline",
"aliases",
"commands\which",
"commands\czinit",
"commands\author",
"git",
"gt",
"gitignore\gitignore",
"starship"


foreach ($module in $coremodules)
{
  Import-Module $PSScriptRoot\core\$module.ps1
}

Import-Module $PSScriptRoot\util\finalize.ps1

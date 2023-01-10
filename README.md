# Powershell

This is a fast, modern, powerful and highly extensible Powershell configuration

![pwsh v2.0 preview](https://github.com/28n/assets/blob/main/powershell/v2.0.png?raw=true)

# ✨ Features

- ⭐ Prompt Customization using [starship](https://github.com/starship/starship)
- 📁 [Terminal Icons](https://github.com/devblackops/Terminal-Icons) for File View
- 🔍 Autocompletion using [PSReadLine](https://github.com/PowerShell/PSReadLine)
- 🔑 Aliases for better Workflow
- 🧰 Utility Commands
- 🚦 Rewritten Git Command, that can be configured to your liking
- 🚋 Goto Command, that too can be configured to your liking
- 🛂 Gitignore Templates
- 💻 additionally, Modular Loading

# ⚡️ Requirements

- Powershell >= 7.3.1
- Git
- Pnpm Package Manager
- Commitizen Conventional Changelog: `npm i -g commitizen`
- a [Nerd Font](https://www.nerdfonts.com/)

# 📦 Installation

_This will be reworked in the future, as this process is long and tedious_

## Install Modules manually

In Powershell, run the following Commands:

`winget install --id Starship.Starship`

`Install-Module -Name Terminal-Icons -Repository PSGallery`

`Install-Module PSReadLine`

or if you are using Scoop:

`scoop bucket add extras`

`scoop install starship`

`scoop install terminal-icons`

`Install-Module PSReadLine`

## Clone this repository

`git clone https://github.com/28n/powershell "$env:HOME\.config\powershell"`

**or**

install manually to `~/.config/powershell`

## Link Custom User Profile to Current User Profile

Open `$PROFILE.CurrentUserCurrentHost` with your favourite Text Editor, e.g. Neovim:

`nvim $PROFILE.CurrentUserCurrentHost`

Add the following text to this file:

```ps1
. $env:USERPROFILE\.config\powershell\28n_profile.ps1
```

# 🚀 Usage

## Command Aliases

- `vim` + `vi` for `nvim`
- `ll` for `ls`
- `grep` for `findstr`
- `tig` to manually execute `tig` executable
- `less` to manually execute `less` executable
- `n` and `npm` for `pnpm`

## Custom Git Command

You may use the git command normally, but i have rewritten to work with the following aliases:

`g`:

- `s` for `status`
- `a` for `add`
- `p` for `push`
- `c` and `commit` to execute commitizen `cz`

## Commitizen Init

You may use the `czinit` command to initialize a commitizen friendly repo in an already existing git repository.

If the repo is already commitizen friendly and this command throws an error, try installing missing deps by running `npm install`

## Gitignore

To see all possible templates, run the `gitignore` command without any flags or with the `-h` or `--help` flag.

To create a `.gitignore` file in your current directory, run the `gitignore` command with any available template name as an argument.

To see a templates content, run the `gitignore` command with the `-s` or `--show` flag. Then append a valid template name to the end. E.g.: `gitignore -s node`

## Goto

This command lets you quickly hop to _my_ most commonly used folders.

`gt`:

- `h` to `~`
- `nv` to `$ENV:LOCALAPPDATA + \nvim\`
- `nvd` to `$ENV:LOCALAPPDATA + \nvim-data\`

## PSReadLine

To delete a PSReadLine Completion Character, press `Ctrl+D`

**NOTE**: If PSReadLine doesn't autocomplete automatically, you should first let the application learn based off of your commands. Type them once, then PSReadLine remembers.

## Oh-My-Posh

As you might have noticed, there are OMP Themes located in this config. Oh My Posh is currently not install, but it will be, when i implement a Prompt Switcher.

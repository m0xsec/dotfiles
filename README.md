# dotfiles

dotfiles and other useful things <3

```shell
git clone --recurse-submodules https://github.com/m0xxz/dotfiles ~/sandbox/dotfiles
```

## zsh

```zsh
#!/bin/zsh
# ~/.zshenv exmaple, make changes as needed per system
ZDOTDIR=$HOME/sandbox/dotfiles/zsh
export KITTY_CONFIG_DIRECTORY=$HOME/sandbox/dotfiles/kitty/
export GOPATH=$HOME/sandbox/go
export PATH=$GOPATH/bin:$HOME/.local/bin:$PATH
export EDITOR=vim
export PAGER=less
export CLICOLOR=1

```

## git

```
# ~/.gitconfig example
[user]
	name = m0x
	email = m0x@m0x.io
	signingkey = 7A687F12E9A61F11!
[credential]
	helper = /usr/libexec/git-core/git-credential-libsecret
[commit]
	gpgsign = true
[init]
	defaultBranch = main

[alias]
	rebase-last-five = "!b=\"$(git branch --no-color | cut -c3-)\" ; h=\"$(git rev-parse $b)\" ; echo \"Current branch: $b $h\" ; c=\"$(git rev-parse $b~4)\" ; echo \"Recreating $b branch with initial commit $c ...\" ; git checkout --orphan new-start $c ; git commit -C $c ; git rebase --onto new-start $c $b ; git branch -d new-start ; git gc"
	squash-all = "!f(){ git reset $(git commit-tree -S HEAD^{tree} -m \"${1:-A new start}\");};f"

```

## kitty
```
# kitty.desktop file
[Desktop Entry]
Version=1.0
Type=Application
Name=kitty
GenericName=Terminal emulator
Comment=Fast, feature-rich, GPU based terminal
TryExec=kitty
Exec=kitty --config /home/m0x/sandbox/dotfiles/kitty/kitty.conf
Icon=kitty
Categories=System;TerminalEmulator;
```
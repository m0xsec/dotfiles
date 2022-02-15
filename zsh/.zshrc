#!/bin/zsh

# ZSH Options / Settings
#HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
#HISTSIZE=50000
#SAVEHIST=50000
#setopt extended_history # Timestamps
#setopt inc_append_history # Real time saves
#setopt share_history # Across shells
unset HISTFILE
unset HISTSIZE
unset SAVEHIST
setopt hist_ignore_all_dups # No dupes in history
setopt hist_verify # Confirm !!
setopt no_clobber # Enforce >! or >|
zstyle ':completion:*' menu select
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# User-scoped machine-local ZSH function path.
# For example, on macOS, Brew's rustup-init puts binaries in ~/.cargo
# ... which means /usr/local is the wrong place to add completions.
# TODO: Use ~/.share instead? What is the right place?
# rustup completions zsh > ~/.local/share/zsh/site-functions/_rustup
# rustup completions zsh cargo > ~/.local/share/zsh/site-functions/_cargo
#fpath+=~/.local/share/zsh/site-functions

#fpath+=$ZDOTDIR/lib/pure
#autoload -U promptinit && promptinit
#prompt pure

#fpath+=$ZDOTDIR/lib/zsh-completions/src
#. $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh
#. $ZDOTDIR/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH Plugins
fpath+=$ZDOTDIR/lib/spaceship-prompt
fpath+=$ZDOTDIR/lib/zsh-completions/src
fpath+=$ZDOTDIR/lib/

. $ZDOTDIR/lib/gpg-agent/gpg-agent.zsh
. $ZDOTDIR/lib/zsh-autosuggestions/zsh-autosuggestions.zsh
. $ZDOTDIR/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. $ZDOTDIR/lib/zsh-async/async.zsh
. $ZDOTDIR/lib/zsh-history-substring-search/zsh-history-substring-search.zsh
. $ZDOTDIR/lib/zsh-rustup-completion/rustup.plugin.zsh

# GPG SSH Agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Wireguard goodies
if [[ $(uname) == 'Linux' ]] {
    alias wgup="nmcli connection up wg0"
    alias wgdown="nmcli connection down wg0"
}

# Handy Aliases for dealing with NVIDIA driver installs on linux
if [[ $(uname) == 'Linux' ]] {
    alias graphical-mode-off="sudo systemctl set-default multi-user.target; echo 'you can now reboot'"
    alias graphical-mode-on="sudo systemctl set-default graphical.target; echo 'you can now reboot'"
}

# WebM -> gif using ffmpeg
# https://askubuntu.com/a/1350795
function webm2gif() {
    ffmpeg -y -i $1 -vf palettegen _tmp_palette.png
    ffmpeg -y -i $1 -i _tmp_palette.png -filter_complex paletteuse -r 10  ${1%.webm}.gif
    rm _tmp_palette.png
}

# macOS specific alises
if [[ $(uname) == 'Darwin' ]] {
  alias reset_launchpad="defaults write com.apple.dock ResetLaunchPad -bool true && killall Dock"
  alias reset_systemui="defaults delete com.apple.systemuiserver && killall SystemUIServer"
}

# direnv if it is installed
if (( $+commands[direnv] )); then; . <(direnv hook zsh); fi

# Don't rebuild on every new shell
autoload -Uz compinit && compinit -C
#autoload -U compinit && compinit

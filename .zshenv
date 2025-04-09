export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="zen"
export TZ="Africa/Cairo"

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"
export PATH="$PATH:/sbin/"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.nvim/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.node/bin"
export PATH="$PATH:$HOME/scripts"

alias ls='eza --icons --color=always'
alias ll='eza -lh --icons --git'
alias la='eza -lha --icons --git'
alias lt='eza -T --icons --git'  # Tree view
alias l1='eza -1 --icons'  # One column view
alias ld='eza -D --icons'  # List only directories

alias i='doas apt install'
alias u='doas apt update && doas apt upgrade -y'
alias s='doas apt remove'
alias s='apt search'
alias vi="$EDITOR"
alias docker='doas docker'
alias rmf='rm -rf'
alias dotfiles='git --git-dir=$HOME/dotfiles.git --work-tree=$HOME'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias dls='docker ps -a'
alias drm='docker rm -f'
alias dcu='docker compose up'
alias dcd='docker compose down'

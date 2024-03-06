PATH=$HOME/go/bin:$HOME/.local/bin:$HOME/.local/nodejs/bin:/usr/local/bin:$PATH
PROJECTS_DIR="$HOME/Projects/code"
DEFAULT_USER="trolleksii"
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cobalt2"
TERM="xterm-256color"
EDITOR="nvim"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000
K9S_CONFIG_DIR=$HOME/.config/k9s

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
set -o extendedglob

# completion plugins
plugins=(gitfast kubectl helm)
source $ZSH/oh-my-zsh.sh

alias l='ls -laF'
alias vim='nvim'
alias nv='nvim'
alias code='nvim' # muscle memory
alias k='kubectl'
alias kk='k9s --headless --crumbsless'
alias kat="kubectl apply -f -<<'EOF'"
alias add='git add'
alias commit='git commit'
alias push='git push'
alias pull='git pull'


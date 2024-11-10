export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$HOME/bin:$HOME/.local/bin:$PATH"
export ESTEE="$HOME/Projects/code/estee"
export PROJECTS_DIR="$HOME/Projects/code"
export DEFAULT_USER="otroian"
export K9S_CONFIG_DIR="$HOME/.config/k9s"
export EDITOR="nvim"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=500000
export SAVEHIST=500000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cobalt2"

plugins=(gitfast docker kubectl helm fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh
alias l='eza -1A --group-directories-first'
alias kat="kubectl apply -f -<<'EOF'"
alias kk='k9s --headless --crumbsless'
alias kkx='k9s --headless --crumbsless --context $(yq ".contexts.[].name" ~/.kube/config | fzf)'
alias add='git add'
alias commit='git commit'
alias clone='git clone'
alias push='git push'
alias pull='git pull'
alias rebase='git rebase'
alias code='nvim'
alias nv='nvim'
alias ns='tmux-sessionizer'
bindkey "ç" fzf-cd-widget

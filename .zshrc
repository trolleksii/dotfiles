export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"
export PROJECTS_DIR="$HOME/projects/code"
export DEFAULT_USER="trolleksii"
export K9S_CONFIG_DIR="$HOME/.config/k9s"
export EDITOR="nvim"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=500000
export SAVEHIST=500000
export FZF_DEFAULT_OPTS="--tmux"
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
alias kk='k9s --headless --crumbsless --splashless'
alias kx='kubectx'
alias kkx='k9s --headless --crumbsless --splashless --context $(yq ".contexts.[].name" ~/.kube/config | fzf)'
alias add='git add'
alias commit='git commit'
alias clone='git clone'
alias push='git push'
alias pull='git pull'
alias rebase='git rebase'
alias nv='nvim'
alias code='nvim $(rg --files --hidden --glob "!.git/*" | fzf)'
alias ns='tmux-sessionizer'
bindkey "ç" fzf-cd-widget

export GH_TOKEN="TOKEN_HERE"

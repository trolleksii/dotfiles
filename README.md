# Installation

For Mac with Homebrew. Linux instructions are similar.

## Git

If you still don't have git installed

```SH
brew install --cask nikitabobko/tap/aerospace # window manager

brew install \
    git git-delta \                  # git with nise differ
    zsh tmux neovim \                # superior coding experience
    fd fzf ripgrep gnu-sed bat eza \ # search and display
    kubectl kubectx k9s helm \       # k8s stuff
    lnav \                           # log viewer tui
    tfswitch \                       # terraform version manager
    jq yq \                          # config processors
    colima \                         # docker replacement
    hey \                            # simpleload testing
    wget curl grpcurl \              # http/grpc client
    cloudflared \                    # tunnel for prototyping public facing apps
    claude                           # ai
    

# terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
cp -r .config/kitty ~/.config
# fonts
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew install --cask font-fira-code-nerd-font
# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./.oh-my-zsh/themes/cobalt2.zsh-theme ~/.oh-my-zsh/themes/
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# Instructions

For Mac with Homebrew. Linux instructions are similar.

```SH
brew install git
```

## Devops stuff

```SH
brew install kubectl k9s kubectx \
    jq yq \
    colima \
    hey 
```

## Zsh

Shell that looks nice and is close to bash.

```SH
brew install zsh
```

## Powerline-patched font with ligatures

Font that looks nice.

[Git repo](https://github.com/tonsky/FiraCode)

```SH
brew tap homebrew/cask-fonts
brew cask install font-fira-code
```


## Oh My Zsh

Zsh cuztomization.

[Website](https://ohmyz.sh/#install)

TLDR:
```SH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


## Tmux and Tmux Plugin Manager

Terminal multiplexer. 

```SH
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
```

Default prefix is `Ctrl + b`.

In tmux, press `prefix` + `I` to install plugins.


## Neovim

Text editor.

```SH
brew install neovim
```

First launch of Neovim may throw some errors but it will install plugins and subsequent launches should be smooth.


## fd, fzf, ripgrep, sed

Tools for searching files. Used in Neovim Telescope plugin.

```SH
brew install fd fzf ripgrep gnu-sed
```


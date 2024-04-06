# Installation

## Packages

### Linux(Arch)

```SH
pacman -S git gcc make fzf ripgrep fd nodejs npm nvim tmux zsh jq kitty ttf-fira-code
```

### MacOS

```SH
brew tap homebrew/cask-fonts
brew install git gcc make fzf ripgrep fd gnu-sed nodejs npm nvim tmux zsh jq kitty font-fira-code
```

## Tmux and zsh config manager

```SH
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Copy configs


```SH
cp -r .config .local .oh-my-zsh .tmux.conf .zshrc ~/
```

Adjust `PATH`, `PROJECTS_DIR`, and `DEFAULT_USER` in `.zshrc`.

## First launch

Install tmux plugins:
1. Launch tmux.
2. Press `prefix` then `I` to install plugins(default prefix is `Ctrl + b`).
3. Restart tmux.

Start `nvim` to install plugins.

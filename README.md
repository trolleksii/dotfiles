# Installation

For Mac with Homebrew. Linux instructions are similar.

## Git

If you still don't have git installed

```SH
brew install git
```

## Devops stuff

jq yq - json and yaml parsers.
hey - load testing tool
colima - container runtime for macOS, if you need to build x86_64 containers on Apple sicicon laptop.

```SH
brew install kubectl k9s kubectx \
    jq yq \
    colima \
    hey 
```

## Kitty

Terminal emulator.

[Website](https://sw.kovidgoyal.net/kitty/binary/
[Git repo](https://github.com/kovidgoyal/kitty)

TLDR:

```SH
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Copy the config

```SH
cp -r .config/kitty ~/.config
```


## Zsh

Customizable shell.

```SH
brew install zsh
```

Copy the rc file

```SH
cp .zshrc ~/
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

Copy theme

```SH
cp ./.oh-my-zsh/themes/cobalt2.zsh-theme ~/.oh-my-zsh/themes/
```

## Tmux and Tmux Plugin Manager

Terminal multiplexer. 

```SH
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Copy config

```SH
cp .tmux.conf ~/
```

To install tmux plugins:
1. Launch tmux.
2. Press `prefix` then `I` to install plugins(default prefix is `Ctrl + b`).
3. Restart tmux.


## Neovim

Text editor.

```SH
brew install neovim
```

Copy config

```SH
cp -r .config/nvim ~/.config
```

First launch of Neovim may throw some errors but it will install plugins and subsequent launches should be smooth.


## Optional neovim dependencies

Tools for searching files. Used in Neovim Telescope plugin. Can speed up file search.

```SH
brew install fd fzf ripgrep gnu-sed
```

# Shortcuts

Only ones that I use frequently.

## Tmux

Tmux will loose sessions on restart of the computer. Use tmux-resurrect to save/restore them. See [sessions](###sessions) section.

`Ctrl + b` is the default prefix.


### Plugin management

`prefix + I` - install plugins.
`prefix + r` - reload config.
`prefix + U` - update plugins.


### Sessions

`prefix + $` - rename session.
`prefix + s` - list sessions.
`prefix + w` - list sessions with windows.
`prefix + d` - detach from session.
`prefix + Ctrl-s` - save session.
`prefix + Ctrl-r` - restore session.


### Splitting

`prefix + c` - split window
`prefix + %` - split pane vertically.
`prefix + E` - equalize panes.


### Moving between panes

These integrate with neovim if you have splits there as well.

`prefix + l` - move to the pane on the right.
`prefix + h` - move to the pane on the left.


### Moving between windows

`prefix + n` - move to the next window.
`prefix + p` - move to the previous window.
`prefix + 0-9` - move to the window with the number.


### More

`prefix + ?` - list shortcuts.


## Neovim

Leader key is `<Space>`.

Note that all key chords must be pressed rather fast. If you press them slowly, Neovim will interpret them as separate key presses.


### Plugin management

`:PackerSync` - update plugins.


### File explorer

`leader + ex` - open file explorer.

`-` - go up a dir.
`<CR>` - open file/dir.
`d` - create directory.
`%` - create file and edit it.
`D` - delete file/dir(will ask for confirmation).
`cd` - change workdir to the currently open.


### Telescope(fuzzy file navigation)

`leader + ff` - find files in workdir.
`leader + fb` - find buffers(open files).
`leader + fg` - live grep in current dir.
`leader + fr` - find git files(like `ff` but only for git repos with respect to .gitignore).

To open multiple files select them with `Tab`/`Shift+Tab` and then press `Ctrl+o`.

`<Ctrl-q>` - add files to the quickfix list.

### Fugitive(git)

In the file buffer:

`leader + gs` - git status.

In the git status buffer:

`co<Space>` - git branch with prompt.
`cb<Space>` - git checkout with prompt.
`s` - stage file.
`u` - unstage file.
`=` - open file diif(to commit chunks in the diff view use visual mode selection and `cc` )
`cc` - commit changes.
`leader + p` - push.
`leader + t` - push to custom origin(prompted for the origin).
`leader + P` - pull(rebase).


### Buffer navigation

`leader + nb` - switch to the next buffer.
`leader + qq` - wipeout(close) current buffer.


### Harpoon (also buffer navitaion)

`leader + a` - add buffer to a quick access list.
`leader + e` - open quick access list.
`leader + h` - access first buffer
`leader + j` - access second buffer
`leader + k` - access third buffer
`leader + l` - access fourth buffer


### Trouble
 
Quickfix and diagnostics.

`leader + xw` - toggle workspace diagnostics.
`leader + xd` - toggle document diagnostics.
`leader + xq` - toggle quickfix.


### LSP

`K` - show documentation for the word under the cursor(like hover in other IDEs).
`gd` - go to definition.
`gD` - go to declaration.
`gs` - signature help
`gr` - references
`<F3>` - format the file content(if supported by the lsp).


### Misc

`leader + w` - toggle line wrap.
`leader + f` - fuzzy find dir in $PROJECTS_DIR and open it in a new tmux session.
`leader + u` - toggle undo tree(tree-like map of changes in the file).

`leader + s` - open sed replace prompt for the word under the cursor.

`leader + k` - move to the previous quicklist item.
`leader + j` - move to the next quicklist item.

In visual selection mode `leader + p` - replace selection with clipboard content and preserve the clipboard.


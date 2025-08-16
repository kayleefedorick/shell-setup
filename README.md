# Personal Zsh + Oh My Zsh Setup for Debian/Ubuntu

This repository installs a **custom Zsh environment** tuned for fast workflows on Debian/Ubuntu systems in my homelab. The installer makes Zsh your login shell, installs Oh My Zsh plus useful plugins, sets up Python 3.11 tooling and useful CLI utilities (e.g. `thefuck`, `eza`, `du-dust`), and copies a curated set of configs, plugins, aliases, and keybindings into your home directory.

All command output is saved to `install.log` while the script shows only light progress messages. **Review `config.sh` before running** - it changes your shell and will overwrite `~/.zshrc`.

---

## One-liner Install

```bash
git clone --recurse-submodules https://github.com/kayleefedorick/shell-setup && \
cd shell-setup && \
chmod +x config.sh install-open-interpreter.sh && \
./config.sh
```

---

## What This Does

### Base System Setup

* Updates apt and installs Python 3.11 tooling, pipx, zsh, curl, wget, lsb-release
* Adds Deadsnakes PPA for Python 3.11 dev/venv/distutils

### Default Shell

* Sets Zsh as the login shell: `sudo usermod --shell /bin/zsh $USER`
* Logout/login required

### Oh My Zsh + Plugins

* Unattended install of Oh My Zsh if not already present
* Plugins included: `history-substring-search`, `zsh-bat`, `you-should-use`, `git`, `copyfile`, `copypath`, `web-search`, `thefuck`, `extract`, `sudo`
* Syntax highlighting (`zsh-syntax-highlighting`) and Esc-1 shortcut for mouse cursor positioning (rxvt-like) via `.shell/mouse.zsh`

### CLI Tools

* `thefuck` via pipx (Python 3.11 venv)
* `eza` via `apt`
* `du-dust` via `deb-get`

### Open Interpreter

* Creates `~/open-interpreter` virtualenv
* Installs `open-interpreter` for local LLM coding assistance

### Custom Environment (`.zshrc`)

The `.zshrc` sets up a **custom environment**:
* PATH includes `$HOME/bin` and `$HOME/.local/bin`
* Loads Oh My Zsh with `robbyrussell` theme (customizable)
* Custom plugins and bindings: history search, mouse support, command shortcuts
* Aliases for productivity and aesthetics:
  * `ls` → `eza --icons`
  * `tree` → `eza -la --icons --tree --total-size --hyperlink`
  * `du` → `dust -r`
  * `howdoi` and `howdoi-windows` scripts
* `erase()` function to clear previous terminal output
* thefuck aliases automatically loaded

### Copies Configs

* `.shell` → `~/.shell`
* Plugins → `~/.oh-my-zsh/custom/plugins/`
* `.zshrc` → `~/.zshrc`
* `howdoi` scripts → `~/`

---

## Files of Interest

* `config.sh` - main installer - run this
* `install-open-interpreter.sh` - Open Interpreter setup
* `.zshrc` - defines the custom environment and aliases
* `install.log` - captures full installer output

---

## Notes

* **Overwrites your `~/.zshrc`** and copies files into your home directory.
* Requires `sudo` for installs and changing login shell.
* Intended for Debian/Ubuntu-based distributions only.
* Always inspect `config.sh` before running.
* Adjust `DEFAULT_USER` in `.zshrc` as needed.

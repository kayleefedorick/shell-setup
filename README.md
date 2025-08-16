# Personal Zsh + Oh My Zsh Setup for Debian/Ubuntu

This repository installs a **custom Zsh environment** tuned for fast workflows on Debian/Ubuntu systems. The installer makes Zsh your login shell, installs Oh My Zsh plus useful plugins, sets up Python 3.11 tooling and CLI utilities (e.g., `thefuck`, `eza`, `du-dust`), and copies a curated set of configs, plugins, aliases, and keybindings into your home directory.

All command output is saved to `install.log` while the script shows only light progress messages. **Review `config.sh` before running** - it changes your shell and will overwrite `~/.zshrc`.

---

## One-liner Install

Install everything including Open Interpreter:

```bash
git clone --recurse-submodules https://github.com/kayleefedorick/shell-setup && \
cd shell-setup && \
chmod +x config.sh install-open-interpreter.sh && \
./config.sh
```

Skip Open Interpreter and `howdoi` scripts:


```bash
git clone --recurse-submodules https://github.com/kayleefedorick/shell-setup && \
cd shell-setup && \
chmod +x config.sh install-open-interpreter.sh && \
./config.sh --no-open-interpreter
```

---

## What This Does

### Base System Setup

* Updates `apt` and installs Python 3.11 tooling, pipx, zsh, curl, wget, lsb-release
* Adds Deadsnakes PPA for Python 3.11 dev/venv/distutils (Ubuntu only; falls back safely on Debian)

### Default Shell

* Sets Zsh as the login shell: `sudo usermod --shell /bin/zsh $USER`
* Logout/login required

### Oh My Zsh + Plugins

* Unattended install if not already present
* Plugins: `history-substring-search`, `zsh-bat`, `you-should-use`, `git`, `copyfile`, `copypath`, `web-search`, `thefuck`, `extract`, `sudo`
* Syntax highlighting via `zsh-syntax-highlighting`
* Esc-1 shortcut for mouse cursor positioning via `.shell/mouse.zsh`

### CLI Tools

* `thefuck` via pipx (Python 3.11 venv)
* `eza` via `apt`
* `du-dust` via `deb-get`

### Open Interpreter (Optional)

* Creates `~/open-interpreter` virtualenv
* Installs `open-interpreter` for local LLM coding assistance
* Skippable via `--no-open-interpreter`

### Custom Environment (`.zshrc`)

The `.zshrc` sets up a **custom, ready-to-use shell**:

* PATH includes `$HOME/bin` and `$HOME/.local/bin`
* Loads Oh My Zsh with `robbyrussell` theme
* Custom plugins and bindings: history search, mouse support, command shortcuts
* Productivity aliases:

  * `ls` → `eza --icons`
  * `tree` → `eza -la --icons --tree --total-size --hyperlink`
  * `du` → `dust -r`
  * `howdoi` and `howdoi-windows` scripts (optional)
* `erase()` function to clear previous terminal output
* Thefuck aliases automatically loaded

### Copies Configs

* `.shell` → `~/.shell`
* Plugins → `~/.oh-my-zsh/custom/plugins/`
* `.zshrc` → `~/.zshrc`
* `howdoi` scripts → `~/` (skipped if `--no-open-interpreter`)

---

## Files of Interest

* `config.sh` - main installer (run this)
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

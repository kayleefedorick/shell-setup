Personal Zsh + Oh My Zsh setup for Debian/Ubuntu systems.
This installer sets up Zsh as your login shell, installs Oh My Zsh, Python 3.11 tooling, pipx-managed CLI tools, and copies my shell configs/plugins to your home directory.

---

## One-liner Install

> **Warning:** Review `config.sh` first - this will change your shell, install software, and overwrite `~/.zshrc`.

```bash
git clone --recurse-submodules https://github.com/kayleefedorick/shell-setup && \
cd shell-setup && \
chmod +x config.sh install-open-interpreter.sh && \
./config.sh
```

---

## What This Does

1. **Updates and installs packages via `apt`:**

   * Python3 tooling, pipx, zsh, curl, lsb-release, wget
   * Adds Deadsnakes PPA to install Python 3.11 + dev/venv/distutils packages

2. **Sets Zsh as the default shell**

   ```bash
   chsh -s /bin/zsh
   ```

   * Log out and back in for it to take effect.

3. **Installs Oh My Zsh and plugins**

   * Oh My Zsh (unattended install)
   * zsh-syntax-highlighting
   * Custom plugins:

     * `zsh-history-substring-search`
     * `zsh-bat`
     * `zsh-you-should-use`

4. **Installs CLI tools**

   * `thefuck` via pipx (Python 3.11 venv)
   * `eza` via `apt`
   * `du-dust` via `deb-get`

5. **Runs Open Interpreter setup**

   * Creates `~/open-interpreter` virtualenv
   * Installs `open-interpreter`
6. **Copies**

  * `.shell` → `~/.shell` (contains my `oh-my-zsh-custom` directory)
  * `zsh-history-substring-search` and `zsh-bat` → `~/.oh-my-zsh/custom/plugins/`
  * `.zshrc` → `~/.zshrc`
  * `howdoi` scripts for quick coding help via local LLM → `~/`

## Files of interest

* `config.sh` - main installer (run this)

## Notes

* **This will overwrite your `~/.zshrc`** and copy files into your home directory.
* Requires `sudo` for installs and `chsh` to change your login shell.
* Intended for Debian/Ubuntu-based distributions only.
* Always inspect `config.sh` before running on any machine.
* Change DEFAULT_USER in .zshrc as needed

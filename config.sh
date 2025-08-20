#!/bin/bash
set -euo pipefail

# --- Config ---
LOGFILE="install.log"
SKIP_OPEN_INTERPRETER=false
TARGET_USER="$USER"

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --no-open-interpreter)
            SKIP_OPEN_INTERPRETER=true
            shift
            ;;
        --user)
            TARGET_USER="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Resolve target user's home directory
TARGET_HOME=$(eval echo "~$TARGET_USER")

# Absolute path of this script’s directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_DIR="$TARGET_HOME/shell-setup"

# Save real terminal stdout for progress messages
exec 3>&1

# Redirect all output (stdout + stderr) to log file
exec >"$LOGFILE" 2>&1

# Keep sudo alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "[*] Updating apt..." >&3
sudo apt update
echo "[✓] Apt updated." >&3

echo "[*] Installing base packages..." >&3
sudo apt install -y software-properties-common curl wget lsb-release zsh rsync
echo "[✓] Base packages installed." >&3

echo "[*] Adding Deadsnakes PPA (Ubuntu only)..." >&3
if sudo add-apt-repository -y ppa:deadsnakes/ppa 2>/dev/null; then
    sudo apt update
    echo "[✓] Deadsnakes PPA added." >&3
else
    echo "[!] Could not add Deadsnakes PPA; assuming Debian." >&3
fi

echo "[*] Installing Python 3.11 and dev tools..." >&3
sudo apt install -y \
    python3-dev python3-pip python3-setuptools python3-venv pipx \
    python3.11 python3.11-venv python3.11-dev python3.11-distutils
echo "[✓] Python installed." >&3

# Copy this repo into target user’s home
echo "[*] Copying shell-setup into $TARGET_HOME..." >&3
sudo -u "$TARGET_USER" mkdir -p "$SETUP_DIR"
sudo rsync -a --delete "$SCRIPT_DIR/" "$SETUP_DIR/"
sudo chown -R "$TARGET_USER":"$TARGET_USER" "$SETUP_DIR"
echo "[✓] shell-setup copied." >&3

# Oh My Zsh install only if not present
if [ ! -d "$TARGET_HOME/.oh-my-zsh" ]; then
    echo "[*] Installing Oh My Zsh for $TARGET_USER..." >&3
    sudo -u "$TARGET_USER" bash -c "cd \"$SETUP_DIR\" && \
        sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended"
    echo "[✓] Oh My Zsh installed." >&3
else
    echo "[=] Oh My Zsh already installed, skipping." >&3
fi

echo "[*] Changing default shell to zsh for $TARGET_USER..." >&3
sudo usermod --shell /bin/zsh "$TARGET_USER"
echo "[✓] Default shell changed." >&3

echo "[*] Installing zsh plugins..." >&3
sudo apt install -y zsh-syntax-highlighting
sudo -u "$TARGET_USER" pipx uninstall thefuck || true
sudo -u "$TARGET_USER" pipx install --python /usr/bin/python3.11 thefuck
echo "[✓] Zsh plugins installed." >&3

# Open Interpreter install
if [ "$SKIP_OPEN_INTERPRETER" = false ]; then
    echo "[*] Installing Open Interpreter..." >&3
    if sudo -u "$TARGET_USER" bash -c "cd \"$SETUP_DIR\" && bash install-open-interpreter.sh"; then
        echo "[✓] Open Interpreter installed." >&3
    else
        echo "[!] Open Interpreter installation failed; continuing." >&3
    fi
else
    echo "[=] Skipping Open Interpreter installation." >&3
fi

echo "[*] Setting up eza repo..." >&3
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | \
    sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | \
    sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
echo "[✓] eza installed." >&3

echo "[*] Installing deb-get and du-dust..." >&3
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | \
    sudo -E bash -s install deb-get
deb-get install du-dust
echo "[✓] deb-get + du-dust installed." >&3

echo "[*] Copying configs and plugins for $TARGET_USER..." >&3
sudo apt install -y bat
sudo -u "$TARGET_USER" bash -c "cd \"$SETUP_DIR\" && \
    cp -r ./.shell \"$TARGET_HOME/.shell\" && \
    cp -r ./zsh-history-substring-search \"$TARGET_HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search\" && \
    cp -r ./zsh-you-should-use \"$TARGET_HOME/.oh-my-zsh/custom/plugins/you-should-use\" && \
    cp -r ./zsh-bat \"$TARGET_HOME/.oh-my-zsh/custom/plugins/zsh-bat\" && \
    cp ./.zshrc \"$TARGET_HOME/\" && \
    if [ \"$SKIP_OPEN_INTERPRETER\" = false ]; then cp ./howdoi.* \"$TARGET_HOME/\" && cp ./howdoi-windows.* \"$TARGET_HOME/\"; fi"
echo "[✓] Configs copied." >&3

echo "[✓] Installation complete for $TARGET_USER. See $LOGFILE for details." >&3

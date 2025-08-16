#!/bin/bash
sudo apt update
sudo apt install -y software-properties-common
sudo apt install -gpg
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3-dev python3-pip python3-setuptools python3-venv pipx
sudo apt install -y python3.11 python3.11-venv python3.11-dev python3.11-distutils
sudo apt install -y zsh curl lsb-release wget
chsh -s /bin/zsh
rm install.sh
rm install.sh.*
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo apt install zsh-syntax-highlighting
pipx uninstall thefuck
pipx install --python /usr/bin/python3.11 thefuck
bash install-open-interpreter.sh
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
deb-get install du-dust
cp -r ./.shell ~/.shell
cp -r ./zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
cp -r ./zsh-you-should-use ~/.oh-my-zsh/custom/plugins/you-should-use
cp -r ./zsh-bat ~/.oh-my-zsh/custom/plugins/zsh-bat
cp ./.zshrc ~
cp ./howdoi.* ~
cp ./howdoi-windows.* ~

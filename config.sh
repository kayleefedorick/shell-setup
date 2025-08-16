#!/bin/bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools python3-venv pipx
sudo apt install python3.11 python3.11-venv python3.11-dev python3.11-distutils
sudo apt install zsh curl lsb-release wget
chsh -s /bin/zsh
rm install.sh
rm install.sh.*
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo apt install zsh-syntax-highlighting
pipx uninstall thefuck
pipx install --python /usr/bin/python3.11 thefuck
bash install-open-interpreter.sh
sudo apt install eza
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
deb-get install du-dust
cp -r ./.shell ~/.shell
cp -r ./zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
cp -r ./zsh-you-should-use ~/.oh-my-zsh/custom/plugins/you-should-use
cp -r ./zsh-bat ~/.oh-my-zsh/custom/plugins/zsh-bat
cp ./.zshrc ~
cp ./howdoi.* ~
cp ./howdoi-windows.* ~

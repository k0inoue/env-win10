#!/bin/sh
# /etc/wsl.conf
if [ uname -r | grep -iq "microsoft" ]; then
  sudo sh -c "echo '[interop]' >> /etc/wsl.conf"
  sudo sh -c "echo 'appendWindowsPath = false' >> /etc/wsl.conf"
fi

# install basic tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  git \
  curl \
  tig \
  ripgrep \
  xclip \
  cmigemo \
  neovim \
  tmux \
  fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# fzf install
cd ~/ && \
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  yes | ~/.fzf/install

# make directories
mkdir -p ~/works/repos/

# extract configs
.profile >> ~/.profile
.bashrc >> ~/.bashrc

cp -r .config ~/

# install /mnt/c/home/bin
curl -sL https://go-toast-downloads.s3.amazonaws.com/v1/toast64.exe -o /mnt/c/home/bin/toast64.exe
curl -sL https://github.com/kaz399/spzenhan.vim/raw/master/zenhan/spzenhan.exe -o /mnt/c/home/bin/spzenhan.exe


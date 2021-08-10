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
  ~/.fzf/install

# make directories
mkdir -p ~/works/repos/

# extract configs


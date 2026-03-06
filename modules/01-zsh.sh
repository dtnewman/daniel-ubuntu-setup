#!/usr/bin/env bash
# Install zsh and oh-my-zsh, set as default shell

sudo apt-get update -y
sudo apt-get install -y zsh

# Install oh-my-zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"

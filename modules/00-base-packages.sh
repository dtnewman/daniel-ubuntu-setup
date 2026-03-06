#!/usr/bin/env bash
# Install base packages needed by other modules and general use

sudo apt-get update -y
sudo apt-get install -y fd-find curl unzip python3-pip npm

# Ubuntu installs fd as fdfind; symlink it to fd
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi

# Install Rust via rustup
if ! command -v rustc &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

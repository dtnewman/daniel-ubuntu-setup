#!/usr/bin/env bash
# Install base packages needed by other modules and general use

sudo apt-get update -y
sudo apt-get install -y fd-find curl unzip python3-pip

# Install nvm and Node.js (latest LTS)
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts

# Ubuntu installs fd as fdfind; symlink it to fd
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
fi

# Install Rust via rustup
if ! command -v rustc &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Install zellij
if ! command -v zellij &>/dev/null; then
    curl -L -o /tmp/zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
    sudo tar -C /usr/local/bin -xzf /tmp/zellij.tar.gz zellij
    sudo chmod +x /usr/local/bin/zellij
    rm /tmp/zellij.tar.gz
    echo "Zellij installed."
else
    echo "Zellij already installed, skipping."
fi

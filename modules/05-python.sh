#!/usr/bin/env bash
# Setup python: alias python -> python3, install virtualenvwrapper

sudo apt-get install -y python3 python3-pip python3-virtualenv

# Create python -> python3 alternative so it works system-wide
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install virtualenvwrapper
pip3 install --user virtualenvwrapper

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install ruff
pip3 install --user ruff

# Add virtualenvwrapper config to .zshrc if not already present
ZSHRC="$HOME/.zshrc"
if ! grep -q "virtualenvwrapper" "$ZSHRC" 2>/dev/null; then
    cat >> "$ZSHRC" << 'EOF'

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh
EOF
    echo "Added virtualenvwrapper config to .zshrc"
fi

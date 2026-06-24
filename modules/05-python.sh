#!/usr/bin/env bash
# Setup python: alias python -> python3, install pipx, virtualenvwrapper, uv, ruff

sudo apt-get install -y python3 python3-pip python3-virtualenv pipx

# Create python -> python3 alternative so it works system-wide
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install CLI tools via pipx (avoids externally-managed-environment error)
# pipx has no upgrade-or-install; install if missing, otherwise upgrade.
for pkg in virtualenvwrapper ruff; do
    if pipx list --short 2>/dev/null | grep -q "^$pkg "; then
        pipx upgrade "$pkg"
    else
        pipx install "$pkg"
    fi
done

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Add virtualenvwrapper config to .zshrc if not already present
ZSHRC="$HOME/.zshrc"
if ! grep -q "virtualenvwrapper" "$ZSHRC" 2>/dev/null; then
    cat >> "$ZSHRC" << 'EOF'

# virtualenvwrapper (installed via pipx — must use pipx venv's Python)
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/share/pipx/venvs/virtualenvwrapper/bin/python
source $HOME/.local/bin/virtualenvwrapper.sh
EOF
    echo "Added virtualenvwrapper config to .zshrc"
fi

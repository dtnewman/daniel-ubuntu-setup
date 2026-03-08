#!/usr/bin/env bash
# Install latest neovim from GitHub releases

LATEST_TAG=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
CURRENT_TAG=""
if command -v nvim &>/dev/null; then
    CURRENT_TAG="v$(nvim --version | head -1 | grep -oP '\d+\.\d+\.\d+')"
fi

if [ "$CURRENT_TAG" != "$LATEST_TAG" ]; then
    NVIM_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
      | grep "browser_download_url.*nvim-linux-x86_64.tar.gz\"" \
      | cut -d '"' -f 4)

    curl -L -o /tmp/nvim-linux-x86_64.tar.gz "$NVIM_URL"
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf /tmp/nvim-linux-x86_64.tar.gz
    rm /tmp/nvim-linux-x86_64.tar.gz
else
    echo "Neovim is already at latest version ($CURRENT_TAG), skipping."
fi

# Symlink nvim binary
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# Point vi and vim to neovim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60

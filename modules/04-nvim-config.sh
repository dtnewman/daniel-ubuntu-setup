#!/usr/bin/env bash
# Clone private nvim config from GitHub (requires SSH key from previous step)

NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG_DIR/.git" ]; then
    echo "Nvim config already cloned, pulling latest..."
    git -C "$NVIM_CONFIG_DIR" pull
else
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.bak.$(date +%s)"
        echo "Backed up existing nvim config."
    fi
    git clone git@github.com:dtnewman/nvim_setup.git "$NVIM_CONFIG_DIR"
fi

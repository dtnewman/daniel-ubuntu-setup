#!/usr/bin/env bash
# Install zsh and oh-my-zsh, set as default shell

sudo apt-get update -y
sudo apt-get install -y zsh

# Install oh-my-zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerline fonts for agnoster theme
if [ ! -d "$HOME/.local/share/fonts/powerline" ]; then
    git clone --depth=1 https://github.com/powerline/fonts.git /tmp/powerline-fonts
    /tmp/powerline-fonts/install.sh
    rm -rf /tmp/powerline-fonts
fi

# Set zsh theme to show username@host in prompt
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' "$HOME/.zshrc"

# Ensure username@host is always shown in prompt (agnoster hides it for DEFAULT_USER)
if ! grep -q 'prompt_context()' "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOF'

# Always show user@host in prompt
prompt_context() {
  prompt_segment black default "%(!.%{%F{yellow}%}.)%n@%m"
}
EOF
fi

# Add zellij alias
if ! grep -q 'alias zj=' "$HOME/.zshrc"; then
    echo -e '\nalias zj="zellij"' >> "$HOME/.zshrc"
fi

# Set zsh as default shell
sudo chsh -s "$(which zsh)" "$USER"

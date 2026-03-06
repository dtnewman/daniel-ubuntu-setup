#!/usr/bin/env bash
# Generate SSH key and prompt user to add it to GitHub (needed for private repos)

KEY_FILE="$HOME/.ssh/id_ed25519"

if [ -f "$KEY_FILE" ]; then
    echo "SSH key already exists at $KEY_FILE, skipping generation."
else
    ssh-keygen -t ed25519 -C "$USER@$(hostname)" -f "$KEY_FILE" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$KEY_FILE"
fi

echo ""
echo "========================================="
echo "Add this public key to your GitHub account:"
echo "  https://github.com/settings/ssh/new"
echo "========================================="
echo ""
cat "${KEY_FILE}.pub"
echo ""

prompt_continue

# Verify GitHub access
echo "Testing GitHub SSH access..."
ssh -T git@github.com 2>&1 || true

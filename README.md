# Ubuntu Setup

Automated setup script for fresh Ubuntu instances. Installs and configures core dev tools in one run.

## What it does

The setup runs numbered modules in order:

1. **Zsh** - Installs zsh and oh-my-zsh, sets zsh as default shell
2. **Neovim** - Installs neovim from the stable PPA, aliases `vi`/`vim` to `nvim`
3. **SSH Key** - Generates an ed25519 SSH key and prompts you to add it to GitHub
4. **Nvim Config** - Clones [nvim_setup](https://github.com/dtnewman/nvim_setup) config from GitHub (requires SSH key from step 3)
5. **Python** - Installs python3, pip, virtualenvwrapper, and [uv](https://github.com/astral-sh/uv); aliases `python` to `python3`

## Usage

```bash
git clone https://github.com/dtnewman/daniel-ubuntu-setup.git
cd daniel-ubuntu-setup
bash setup.sh
```

Log out and back in after the script completes for all changes to take effect.

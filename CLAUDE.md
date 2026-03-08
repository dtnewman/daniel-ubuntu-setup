# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Automated setup scripts for fresh Ubuntu instances. A single entry point (`bash setup.sh`) runs numbered module scripts in sequence to install and configure dev tools.

## Running

```bash
bash setup.sh
```

There is no build, lint, or test step — this is a collection of shell scripts.

## Architecture

- `setup.sh` — Entry point. Sources each `modules/[0-9]*.sh` file in order. Exports `SCRIPT_DIR` and a `prompt_continue` helper for modules to use.
- `modules/` — Numbered shell scripts (00–05) that each handle one concern. Execution order matters: SSH key (03) must come before nvim config clone (04).

All scripts use `set -euo pipefail` (set in `setup.sh` and inherited). Target platform is Ubuntu x86_64.

## Idempotency

These scripts are designed to be safely re-run on the same machine. All new code must follow these patterns:

- **Tool installations**: guard with `command -v` checks (e.g., `if ! command -v rustc &>/dev/null; then ... fi`)
- **Directory creation/cloning**: check existence first (e.g., `if [ ! -d "$HOME/.nvm" ]; then ... fi`); if already cloned, `git pull` instead of re-cloning
- **Dotfile modifications** (`.zshrc`, etc.): always `grep` before appending to avoid duplicates
- **pipx packages**: use `pipx upgrade-or-install` instead of `pipx install` (which errors if already installed)
- **Binary downloads**: compare installed version to latest before re-downloading (see neovim module for example)

## Conventions

- New modules: create `modules/NN-name.sh` with the next available number.
- Neovim and zellij are installed from prebuilt GitHub release binaries, not apt.

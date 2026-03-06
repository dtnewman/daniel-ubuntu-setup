#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# Helper available to all modules
export SCRIPT_DIR

prompt_continue() {
    echo ""
    read -rp "Press Enter to continue (or Ctrl+C to abort)..." _
    echo ""
}

export -f prompt_continue

echo "=== Ubuntu Instance Setup ==="
echo ""

# Run all numbered module scripts in order
for module in "$MODULES_DIR"/[0-9]*.sh; do
    [ -f "$module" ] || continue
    module_name="$(basename "$module")"
    echo "--- Running: $module_name ---"
    source "$module"
    echo "--- Done: $module_name ---"
    echo ""
done

echo "=== Setup complete! Log out and back in for all changes to take effect. ==="

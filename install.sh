#!/bin/bash

echo -e "\n\nInstalling packages..."
apt install -y peaclock gotop root-repo sudo

echo -e "\n\nSetting permissions"
chmod +x ui.sh
chmod +x launch-app

echo -e "\n\nAquiring SuperUser"
if su -c "echo 'root access granted'" >/dev/null 2>&1; then
    echo "SuperUser privileges available !"
else
    echo "SuperUser privileges un-available !"
    echo "No root ? What, you scared to trip Knox or void your warrenty ? Boo hoo"
fi

echo -e "\n\nAdding aliases to shell configuration"

# Detect shell and append aliases
SHELL_NAME=$(basename "$SHELL")
RC_FILE=""

if [ "$SHELL_NAME" = "bash" ]; then
    RC_FILE="$HOME/.bashrc"
elif [ "$SHELL_NAME" = "zsh" ]; then
    RC_FILE="$HOME/.zshrc"
fi

# Determine the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -n "$RC_FILE" ]; then
    # Avoid adding duplicates
    grep -qxF "alias ui='bash \"$SCRIPT_DIR/ui.sh\"'" "$RC_FILE" || \
        echo "alias ui='bash \"$SCRIPT_DIR/ui.sh\"'" >> "$RC_FILE"
    grep -qxF "alias launch='bash \"$SCRIPT_DIR/launch-app\"'" "$RC_FILE" || \
        echo "alias launch='bash \"$SCRIPT_DIR/launch-app\"'" >> "$RC_FILE"
    echo "Aliases added to $RC_FILE. Reload your shell or run 'source $RC_FILE' to apply them."
else
    echo "Shell not recognized. Skipping alias setup."
fi


echo -e "\n\nRun 'ui' to start the tmux session and 'launch' to launch applications"

echo "Done ! | @z3r0n3br4instorm"

#!/usr/bin/env bash
set -euo pipefail

DEV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DEV_DIR/macOS/qmk/planck_ez/qwertyMac"
FORK="$HOME/Documents/qmk_firmware"
DST="$FORK/keyboards/zsa/planck_ez/keymaps/qwertyMac"
KB="zsa/planck_ez/glow"         

# QMK + the STM32 DFU flasher 
command -v qmk      >/dev/null 2>&1 || brew install qmk/qmk/qmk
command -v dfu-util >/dev/null 2>&1 || brew install dfu-util

# QMK firmware installation
if [ ! -d "$FORK" ]; then
    cd $HOME/Documents
    git clone https://github.com/R-Pax/qmk_firmware.git "$FORK"
fi

qmk setup -H "$FORK" -y

# Add config files to qmk
mkdir -p "$DST"
ln -sf "$SRC/config.h"    "$DST/config.h"
ln -sf "$SRC/keymap.json" "$DST/keymap.json"
[ -f "$SRC/keymap.c" ] && ln -sf "$SRC/keymap.c" "$DST/keymap.c"

# Compile and flash
qmk compile -kb "$KB" -km qwertyMac
echo
qmk flash -kb "$KB" -km qwertyMac
echo "Flashing, reset the keyboard"

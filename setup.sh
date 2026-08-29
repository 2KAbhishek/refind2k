#!/usr/bin/env bash
set -e

current_dir="${BASH_SOURCE[0]%/*}"
[[ "$current_dir" == "${BASH_SOURCE[0]}" || "$current_dir" == "." ]] && current_dir="$PWD"
readonly current_dir

cmd_sudo() {
    if [[ "$EUID" -ne 0 ]] && command -v sudo &>/dev/null; then
        sudo "$@"
    else
        "$@"
    fi
}

echo -e "\u001b[32;1mWelcome to refind2k...\u001b[0m"

# Detect ESP location, unless user override provided
if [ -z "$ESP" ]; then
    if [ -d "/boot/efi/EFI" ]; then
        ESP="/boot/efi"
    elif [ -d "/boot/EFI" ]; then
        ESP="/boot"
    elif [ -d "/efi/EFI" ]; then
        ESP="/efi"
    else
        ESP="/boot/efi"
        echo -e "\u001b[33;1mwarn: could not find ESP, falling back to /boot/efi\u001b[0m"
        echo -e "\u001b[33;1mwarn: run ESP=/path/to/esp $0 to override\u001b[0m"
    fi
fi

setup_refind() {
    if [ ! -d "$ESP/EFI/refind" ]; then
        echo -e "\u001b[33;1mwarn: $ESP/EFI/refind directory not found. Please install rEFInd first.\u001b[0m"
        return 0
    fi

    if [ -f "$ESP/EFI/refind/refind.conf" ]; then
        if [ ! -f "$ESP/EFI/refind/refind.conf.bak" ]; then
            cmd_sudo cp "$ESP/EFI/refind/refind.conf" "$ESP/EFI/refind/refind.conf.bak"
        fi
        if ! grep -Fq "include refind2k/refind2k.conf" "$ESP/EFI/refind/refind.conf" 2>/dev/null; then
            echo "include refind2k/refind2k.conf" | cmd_sudo tee -a "$ESP/EFI/refind/refind.conf" >/dev/null
        fi
    fi

    cmd_sudo mkdir -p "$ESP/EFI/refind/refind2k"
    cmd_sudo cp -r "$current_dir/banners" "$current_dir/icons" "$current_dir/refind2k.conf" "$ESP/EFI/refind/refind2k/"
}

uninstall_refind() {
    if [ -f "$ESP/EFI/refind/refind.conf.bak" ]; then
        cmd_sudo cp "$ESP/EFI/refind/refind.conf.bak" "$ESP/EFI/refind/refind.conf"
    fi
    cmd_sudo rm -rf "$ESP/EFI/refind/refind2k"
}

if [ "$1" == "-u" ] || [ "$1" == "--uninstall" ]; then
    uninstall_refind
    echo -e "\u001b[34;1mDone.\u001b[0m"
    exit 0
fi

setup_refind
echo -e "\u001b[34;1mDone.\u001b[0m"

#!/bin/bash

echo -e "\u001b[32;1mWelcome to refind2k...\u001b[0m"
echo -e "\u001b[31;1mWarning! sudo password is required.\u001b[0m"

# Detect ESP location, unless user override provided
# NOTE: does not check actual partitions, as someone may have >1 ESP
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

function setup_refind {
    sudo cp "$ESP/EFI/refind/refind.conf" "$ESP/EFI/refind/refind.conf.bak"
    echo "include refind2k/refind2k.conf" | sudo tee "$ESP/EFI/refind/refind.conf"
    sudo mkdir -p "$ESP/EFI/refind/refind2k"
    sudo cp -r banners/ icons/ refind2k.conf "$ESP/EFI/refind/refind2k/"
}

function uninstall_refind {
    sudo cp "$ESP/EFI/refind/refind.conf.bak" "$ESP/EFI/refind/refind.conf"
    sudo rm -rf "$ESP/EFI/refind/refind2k"
}

if [ "$1" == "-u" ] || [ "$1" == "--uninstall" ]; then
    uninstall_refind
    echo -e "\u001b[34;1mDone.\u001b[0m"
    exit 0
fi

setup_refind
echo -e "\u001b[34;1mDone.\u001b[0m"

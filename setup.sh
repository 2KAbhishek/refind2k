#!/bin/bash

function setup_refind {
    sudo cp /boot/efi/EFI/refind/refind.conf /boot/efi/EFI/refind/refind.conf.bak
    echo "include refind-dark/refind-dark.conf" | sudo tee /boot/efi/EFI/refind/refind.conf
    sudo mkdir -p /boot/efi/EFI/refind/refind-dark
    sudo cp -r banners/ icons/ refind-dark.conf /boot/efi/EFI/refind/refind-dark/
}

function uninstall_refind {
    sudo cp /boot/efi/EFI/refind/refind.conf.bak /boot/efi/EFI/refind/refind.conf
    sudo rm -rf /boot/efi/EFI/refind/refind-dark
}

echo -e "\u001b[32;1mWelocme to refind-dark...\u001b[0m"
echo -e "\u001b[31;1mWarning! sudo password is required.\u001b[0m"

if [ "$1" == "-u" ] || [ "$1" == "--uninstall" ]; then
    uninstall_refind
    echo -e "\u001b[34;1mDone.\u001b[0m"
    exit 0
fi

setup_refind
echo -e "\u001b[34;1mDone.\u001b[0m"

#!/bin/bash

function setup_refind {
sudo mkdir -p /boot/efi/EFI/refind/refind-dark
echo "include refind-dark/refind-dark.conf" | sudo tee /boot/efi/EFI/refind/refind.conf
sudo cp -r icons /boot/efi/EFI/refind/refind-dark/
sudo cp -iv refind-dark.conf /boot/efi/EFI/refind/refind-dark/refind-dark.conf
}

echo -e "\u001b[32;1mSetting up refind-dark...\u001b[0m"
echo -e "\u001b[31;1mWarning! sudo password is required.\u001b[0m"
setup_refind
echo -e "\u001b[34;1mDone.\u001b[0m"

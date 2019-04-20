echo "\u001b[32;1mSetting up Refind-Dark..."
echo "\u001b[31;1mWarning! Admin password is required."
sudo mkdir /boot/efi/EFI/refind/Refind-Dark
sudo cp -ivr icons /boot/efi/EFI/refind/Refind-Dark/icons
sudo cp -iv Refind-Dark.conf /boot/efi/EFI/refind/Refind-Dark/Refind-Dark.conf
sudo echo include Refind-Dark/Refind-Dark.conf >> /boot/efi/EFI/refind/refind.conf
echo "\u001b[34;1mDone."
# Refind-Dark
A minimalist dark theme for rEFInd.

![Refind-Dark](https://i.imgur.com/Czhbdot.png)

### Installation:

1. Clone git repository to your $HOME directory.
   ```
   git clone https://github.com/2kabhishek/Refind-Dark.git
   ```

2. Locate refind directory under EFI partition. For most Linux based system is commonly `/boot/efi/EFI/refind/`. Copy theme directory to it. You can change `bg.png` to change the background.

   ```
   sudo cp -r Refind-Dark/refind-dark /boot/efi/EFI/refind/refind-dark
   ```

3. To enable the theme add `include refind-dark/refind-dark.conf` at the end of `refind.conf`.
   ```
   sudo nano /boot/efi/EFI/refind/refind.conf
   ```

**More information**

[rEFInd](http://www.rodsbooks.com/refind/) Official rEFInd website

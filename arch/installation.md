# Complete Arch Linux Installation Guide

## Introduction
This guide provides step-by-step instructions for installing Arch Linux from scratch with disk encryption, LVM, and GNOME desktop environment. This guide is written based on: [How To Install Arch Linux: Step-by-Step Guide](https://www.youtube.com/watch?v=FxeriGuJKTM&t)

## 1. Preparation

### 1.1 Download and Create Installation Media
1. Download the latest Arch Linux ISO from the [official website](https://archlinux.org/download/)
2. Create a bootable USB drive:
   - On Windows: Use Rufus or similar tools

### 1.2 Boot from USB
1. Insert the USB drive into your computer
2. Restart your computer and boot from the USB drive
3. Select "Arch Linux install medium" from the boot menu

## 2. Initial Setup

### 2.1 Connect to WiFi [Optional]
1. Check your wireless interface name:
   ```
   ip addr show
   ```
   Note your wireless interface (e.g., `wlan0`)

2. Connect to WiFi using `iwctl`:
   ```
   iwctl
   ```

3. Within the `iwctl` prompt:
   ```
   station wlan0 get-networks     # List available networks (replace wlan0 with your interface)
   station wlan0 connect "WiFi Name"     # Connect to a network (use quotes for names with spaces)
   # Enter the passphrase when prompted
   exit
   ```

4. Verify connection by checking if you've received an IP address:
   ```
   ip addr show
   ```

### 2.2 Set Root Password
```
passwd
```
Enter and confirm a temporary root password for the installation process.

## 3. Disk Partitioning

### 3.1 Identify Target Disk
```
lsblk
```
Identify the disk where you want to install Arch Linux (e.g., `/dev/nvme0n1`, `/dev/sda`)

### 3.2 Partition the Disk
```
fdisk /dev/nvme0n1     # Replace with your disk
```

Within the `fdisk` prompt:
1. Enter `g` to create a new GPT partition table
2. Create EFI partition:
   ```
   n     # New partition
   1     # Partition number
   [Enter]     # Default first sector
   +1G       # Size for EFI partition
   ```

3. Create boot partition:
   ```
   n     # New partition
   2     # Partition number
   [Enter]     # Default first sector
   +1G     # Size for boot partition
   ```

4. Create LVM partition:
   ```
   n     # New partition
   3     # Partition number
   [Enter]     # Default first sector
   [Enter]     # Use all remaining space
   ```

5. Change the type of the LVM partition:
   ```
   t     # Change partition type
   3     # Partition number 3
   44    # Type 44 for LVM
   ```

6. Write changes and exit:
   ```
   w
   ```

### 3.3 Format Partitions

1. Format the EFI partition:
   ```
   mkfs.fat -F32 /dev/nvme0n1p1
   ```

2. Format the boot partition:
   ```
   mkfs.ext4 /dev/nvme0n1p2
   ```

3. Set up encryption on the LVM partition:
   ```
   cryptsetup luksFormat /dev/nvme0n1p3
   ```
   Type `YES` (in capital letters) to confirm and enter a strong passphrase. You'll need this passphrase every time you boot your system.

4. Unlock the encrypted partition:
   ```
   cryptsetup open --type luks /dev/nvme0n1p3 lvm
   ```
   Enter the passphrase you created.

### 3.4 Setup Logical Volume Management (LVM)

1. Create a physical volume:
   ```
   pvcreate /dev/mapper/lvm
   ```

2. Create a volume group:
   ```
   vgcreate volgroup0 /dev/mapper/lvm
   ```

3. Create logical volumes:
   ```
   lvcreate -L 30GB volgroup0 -n lv_root     # Root partition (adjust size as needed)
   lvcreate -L 250GB volgroup0 -n lv_home    # Home partition (adjust size as needed)
   ```
   Note: You can adjust the sizes based on your disk capacity and needs.

4. Activate volume groups:
   ```
   modprobe dm_mod
   vgscan
   vgchange -ay
   ```

5. Format logical volumes:
   ```
   mkfs.ext4 /dev/volgroup0/lv_root
   mkfs.ext4 /dev/volgroup0/lv_home
   ```

### 3.5 Mount Filesystems

1. Mount the root filesystem:
   ```
   mount /dev/volgroup0/lv_root /mnt
   ```

2. Create and mount directories for other filesystems:
   ```
   mkdir /mnt/boot
   mount /dev/nvme0n1p2 /mnt/boot
   
   mkdir -p /mnt/boot/EFI
   mount /dev/nvme0n1p1 /mnt/boot/EFI
   
   mkdir /mnt/home
   mount /dev/volgroup0/lv_home /mnt/home
   ```

## 4. System Installation

### 4.1 Install Base System
```
pacstrap -i /mnt base base-devel linux linux-firmware
```

### 4.2 Generate Fstab
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```

Verify the generated fstab:
```
cat /mnt/etc/fstab
```
You should see entries for root (`/`), boot (`/boot`), EFI (`/boot/EFI`), and home (`/home`).

### 4.3 Chroot into the New System
```
arch-chroot /mnt
```

## 5. Configure the System

### 5.1 Install Essential Packages
```
pacman -S base-devel dosfstools grub efibootmgr gnome gnome-tweaks lvm2 mtools vim networkmanager openssh os-prober sudo
```

### 5.2 Install Kernel and Headers
```
pacman -S linux linux-headers linux-lts linux-lts-headers linux-firmware
```

### 5.3 Install GPU Drivers
Check your GPU type:
```
lspci | grep -e VGA -e 3D
```

Install the appropriate driver:

- For NVIDIA:
  ```
  pacman -S nvidia nvidia-utils nvidia-lts
  ```

- For AMD:
  ```
  pacman -S xf86-video-amdgpu
  ```

- For Intel:
  ```
  pacman -S xf86-video-intel
  ```

### 5.4 Install Hardware Video Acceleration (Optional)

- For Intel:
  ```
  pacman -S libva-intel-driver intel-media-driver
  ```

- For AMD:
  ```
  pacman -S libva-mesa-driver
  ```

### 5.5 Configure Initramfs
Edit the mkinitcpio configuration:
```
vim /etc/mkinitcpio.conf
```

Find the `HOOKS` line and modify it to include `encrypt` and `lvm2` between `block` and `filesystems`:
```
HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
```

Generate the initramfs:
```
mkinitcpio -p linux
mkinitcpio -p linux-lts
```

### 5.6 Set Locale
Edit the locale.gen file:
```
vim /etc/locale.gen
```

Uncomment the locales you want to use (at minimum):
```
en_US.UTF-8 UTF-8
he_IL.UTF-8 UTF-8  # Optional, for Hebrew support
```

Generate the locales:
```
locale-gen
```

Create locale.conf:
```
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

### 5.7 Set Root Password
```
passwd
```
Enter and confirm a strong root password.

### 5.8 Create User Account
```
useradd -m -g users -G wheel username  # Replace "username" with your desired username
passwd username  # Set password for the new user
```

### 5.9 Configure Sudo
Edit the sudoers file:
```
visudo
```

Uncomment the following line:
```
%wheel ALL=(ALL:ALL) ALL
```

## 6. Configure Bootloader

### 6.1 Edit GRUB Configuration
Edit the GRUB default configuration:
```
vim /etc/default/grub
```

Find the `GRUB_CMDLINE_LINUX_DEFAULT` line and modify it to include:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet cryptdevice=/dev/nvme0n1p3:volgroup0"
```

### 6.2 Install GRUB
```
grub-install --target=x86_64-efi --bootloader-id=grub-uefi --recheck
```

Copy locale:
```
mkdir -p /boot/grub/locale
cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
```

Generate GRUB configuration:
```
grub-mkconfig -o /boot/grub/grub.cfg
```

## 7. Enable Services

Enable display manager:
```
systemctl enable gdm
```

Enable network manager:
```
systemctl enable NetworkManager
```

## 8. Finish Installation

Exit the chroot environment:
```
exit
```

Unmount all partitions:
```
umount -R /mnt
```

Reboot:
```
reboot
```

Remove the installation USB drive when prompted.

## 9. Post-Installation Configuration

### 9.1 Fix Windows Boot Entry (Dual-Boot Only)
If you have Windows installed and the entry is duplicated or incorrect:
```
efibootmgr -v  # List boot entries
efibootmgr -b XXXX -B  # Replace XXXX with the Windows boot entry number to delete
```

### 9.2 Configure GNOME Environment

Set Alt+Shift keyboard shortcut for input source switching:
```
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"
```

Add terminal shortcut:
1. Go to: Settings → Keyboard → View and customize shortcuts → Custom shortcuts → +
2. Name: Terminal
3. Command: kgx
4. Shortcut: Ctrl + Alt + T

### 9.3 Enable Multilib Repository (For Steam)
Edit pacman configuration:
```
sudo vim /etc/pacman.conf
```

Uncomment the following lines:
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Update package databases:
```
sudo pacman -Sy
```

### 9.4 Configure Flameshot (Optional)
Add a shortcut for the Flameshot screenshot tool:
1. Go to: Settings → Keyboard → View and customize shortcuts → Custom shortcuts → +
2. Name: Flameshot
3. Command: script --command "QT_QPA_PLATFORM=wayland flameshot gui" /dev/null
4. Set your preferred keyboard shortcut (e.g., Print Screen key)


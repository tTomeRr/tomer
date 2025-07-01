#!/bin/bash

echo "Starting Arch Linux bootstrap installation..."

sudo pacman -Syu --noconfirm

system_packages=(
    "git"
    "vim"
    "neovim"
    "openssh"
    "tree"
    "firefox"
    "python"
    "flameshot"
    "qbittorrent"
    "steam"
    "bat"
)

dev_packages=(
    "docker"
    "kubectl"
    "helm"
    "nodejs"
    "npm"
)

driver_packages=(
    "nvidia"
    "nvidia-utils" 
    "lib32-nvidia-utils" 
    "nvidia-settings"
)

aur_packages=(
    "anki"
    "visual-studio-code-bin"
    "openshift-client-bin"
    "spotify"
)

echo "Installing system packages..."
sudo pacman -S --noconfirm ${system_packages[@]}

echo "Installing development packages..."
sudo pacman -S --noconfirm ${dev_packages[@]}

echo "Installing driver packages..."
sudo pacman -S --noconfirm ${driver_packages[@]}

if ! command -v yay &> /dev/null; then
    echo "Installing yay AUR helper..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "Installing AUR packages..."
yay -S --noconfirm ${aur_packages[@]}

echo "Enabling services..."
sudo systemctl enable --now sshd
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

mkdir -p ~/.config/systemd/user/

cat << EOF > ~/.config/systemd/user/qbittorrent.service
[Unit]
Description=qBittorrent Client
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/qbittorrent
Restart=on-failure

[Install]
WantedBy=default.target
EOF

systemctl --user enable qbittorrent.service
systemctl --user start qbittorrent.service

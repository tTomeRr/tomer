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
    "man-db"
    "man-pages"
    "code"
)

dev_packages=(
    "docker"
    "docker-compose"
    "kubectl"
    "helm"
    "nodejs"
    "npm"
    "xclip"
    "gpaste"
)

driver_packages=(
    "nvidia"
    "nvidia-utils" 
    "lib32-nvidia-utils" 
    "nvidia-settings"
)

lint_packages=(
    "yamllint"
    "flake8" 
    "shellcheck" 
)

aur_packages=(
    "anki"
    "openshift-client-bin"
    "spotify"
    "git-completion"
)

echo "Installing system packages..."
sudo pacman -S --noconfirm ${system_packages[@]}

echo "Installing development packages..."
sudo pacman -S --noconfirm ${dev_packages[@]}

echo "Installing driver packages..."
sudo pacman -S --noconfirm ${driver_packages[@]}

echo "Installing lint packages..."
sudo pacman -S --noconfirm ${lint_packages[@]}

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


# Create autostart directory if it doesn't exist
mkdir -p ~/.config/autostart

# Create autostart file for GPaste
cat > ~/.config/autostart/gpaste.desktop << EOF
[Desktop Entry]
Type=Application
Name=GPaste
Exec=gpaste-client start
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

# If using GPaste with Super+ V - Disable GNOME's Super+V notification binding: 
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>m']"

# Install better Hebrew fonts
sudo pacman -S noto-fonts noto-fonts-extra

sudo tee /etc/fonts/local.conf > /dev/null << 'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <match target="pattern">
   <test name="lang" compare="contains">
     <string>he</string>
   </test>
   <edit name="family" mode="prepend" binding="strong">
     <string>Noto Sans Hebrew</string>
   </edit>
 </match>
 <match target="pattern">
   <test name="lang" compare="contains">
     <string>he</string>
   </test>
   <test name="family">
     <string>serif</string>
   </test>
   <edit name="family" mode="prepend" binding="strong">
     <string>Noto Serif Hebrew</string>
   </edit>
 </match>
</fontconfig>
EOF

fc-cache -fv

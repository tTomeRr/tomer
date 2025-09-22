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
    "extension-manager"
    "gnome-browser-connector"
    "alacritty"
    "tmux"
    "bash-completion"
    "gamemode"
    "lib32-gamemode"
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
    "azure-cli"
    "go"
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
    "shfmt"
    "python-black"
    "python-isort"
    "golangci-lint"
    "gofumpt"
)

aur_packages=(
    "anki"
    "openshift-client-bin"
    "spotify"
    "git-completion"
    "prettier"
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

sudo usermod -aG gamemode $USER


## Gamemode ##
sudo tee /etc/gamemode.ini << 'EOF'
[general]
reaper_freq=5
desiredgov=performance
desiredprof=performance
igpu_desiredgov=powersave
igpu_power_threshold=0.3
softrealtime=off
renice=10
ioprio=1
inhibit_screensaver=1
disable_splitlock=1

[filter]

[gpu]
apply_gpu_optimisations=accept-responsibility
gpu_device=0
amd_performance_level=high

[cpu]
park_cores=no
pin_cores=yes

[supervisor]
require_supervisor=0

[custom]
script_timeout=10
EOF

# To add games to gamemode via Steam:
# Open Steam, Right-click on the game
# Select Properties. In Launch Options, add:
# gamemoderun %command%




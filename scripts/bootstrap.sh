#!/bin/bash

known_compatible_distros=(
                        "Ubuntu"
                        "Debian"
                        "Arch"
                        "Manjaro"
                    )

function detect_distro_phase() 
{
    for i in "${known_compatible_distros[@]}"; 
    do
        uname -a | grep "${i}" -i > /dev/null
        if [ "$?" = "0" ]; 
            then
                distro="${i^}"
                break
        fi
    done
}

function detect_gnome()
{
    ps -e | grep -E '^.* gnome-session$' > /dev/null
    if [ $? -ne 0 ];
        then
            return 0
    fi
    VERSION=`gnome-session --version | awk '{print $2}'`
    DESKTOP="GNOME"
    return 1
}

detect_distro_phase

case $distro in

    Ubuntu | Debian)

        echo "----------------------------------------"
        echo ">       [1/10] Updating System         <"
        echo "----------------------------------------"
        yes | sudo apt update && sudo apt upgrade && sudo apt install git

        echo "------------------------------------------"
        echo ">       [2/10] Installing Firefox         <"
        echo "------------------------------------------"
        sudo apt install firefox

        echo "---------------------------------------------"
        echo ">       [3/10] Removing LibreOffice         <"
        echo "---------------------------------------------"
        yes | sudo apt remove --purge libreoffice*
        sudo apt clean
        yes | sudo apt autoremove

        if detect_gnome;
            then
                echo "------------------------------------------------"
                echo ">       [4/10] Installing Gnome Tweaks         <"
                echo "------------------------------------------------"
                yes | sudo apt install gnome-tweaks
                gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
        else
            echo "------------------------------------------------------------------"
            echo ">       [4/10] Gnome not detected, skipping gnome-tweaks         <"
            echo "------------------------------------------------------------------"
        fi

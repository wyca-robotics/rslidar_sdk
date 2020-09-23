#!/bin/bash

sudo apt install -y libpcap-dev

#RSLidar Ip config
{
        echo 'network:'
        echo '  version: 2'
        echo '  renderer: NetworkManager'
        echo '  ethernets:'
        echo '    eno1:'
        echo '      dhcp4: no'
        echo '      dhcp4-overrides:'
        echo '        use-routes: false'
        echo '      dhcp6: no'
        echo '      addresses: [192.168.1.102/24, ]'
        echo '      gateway4:  0.0.0.0'
} | sudo tee /etc/netplan/02-rslidar_staticip.yaml
sudo netplan apply

# create auto start

if [ ! -d "~.config/autostart" ]; then
    mkdir -p ~/.config/autostart
fi
if [ -f "~/.config/autostart/startup_rslidar.desktop" ]; then
    rm ~/.config/autostart/startup_rslidar.desktop
fi

echo "[Desktop Entry]" >> ~/.config/autostart/startup_rslidar.desktop
echo "Type=Application" >> ~/.config/autostart/startup_rslidar.desktop
echo "Exec=terminator -e \"bash -i -c 'sleep 15 && source ~/rslidar_ws/devel/setup.bash && roslaunch rslidar_sdk start.launch'\"" >> ~/.config/autostart/startup_rslidar.desktop
echo "Hidden=false" >> ~/.config/autostart/startup_rslidar.desktop
echo "Name[en_US]=startup_rslidar" >> ~/.config/autostart/startup_rslidar.desktop
echo "Name=startup_rslidar" >> ~/.config/autostart/startup_rslidar.desktop
echo "Comment[en_US]=startup_rslidar" >> ~/.config/autostart/startup_rslidar.desktop
echo "Comment=startup_rslidar" >> ~/.config/autostart/startup_rslidar.desktop

# create launcher desktop icon
#sudo cp $HOME/Elodie_ws/src/install/wycaico.png /etc/wyca/install/
if [ ! -f "$HOME/Desktop/startup.desktop" ]; then
    echo "Creating desktop shortcut"
    echo "[Desktop Entry]" >> ~/Desktop/startup_rslidar.desktop
    echo "Type=Application" >> ~/Desktop/startup_rslidar.desktop
    echo "Exec=terminator -e \"bash -i -c 'sleep 15 && source ~/rslidar_ws/devel/setup.bash && roslaunch rslidar_sdk start.launch'\""   >> ~/Desktop/startup.desktop
    echo "Icon=~/elodie1_ws/src/install/wycaico.png"  >> ~/Desktop/startup_rslidar.desktop
    echo "Name[en_US]=startup_rslidar" >> ~/Desktop/startup_rslidar.desktop
    echo "Name=startup_rslidar" >> ~/Desktop/startup_rslidar.desktop
    echo "Comment[en_US]=startup_rslidar" >> ~/Desktop/startup_rslidar.desktop
    echo "Comment=startup_rslidar" >> ~/Desktop/startup_rslidar.desktop
    chmod +x ~/Desktop/startup_rslidar.desktop
fi

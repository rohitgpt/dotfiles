#Adding wireless network to autoconnect 
echo "network={\n\tssid=\"Awesome\"\n\tpsk=14d695fead2c42be422ee8f51fcbaeb222f32abc29ce18737b863361f00ef2f6\n\tpriority=1\n}" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf

#change password
passwd

#Expand the root file system from the Advanced options in raspi-config
sudo raspi-config

#installing oh-my-zsh
sudo apt-get install -y vim git exfat-fuse zsh ntfs-3g fonts-powerline
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "alias upd='sudo apt-get update && sudo apt-get upgrade -y'" >> .zshrc

hd=/home/pi/Maxtor
mkdir $hd

#creating auto mount on bootup for hd
sudo blkid | grep Maxtor | awk '{print $4 $5}' | awk -F '"' '{print "UUID="$2" "$hd" "$4" defaults,auto,users 0 0"}' | sudo tee -a /etc/fstab

#configuring samba 
sudo apt-get install samba samba-common-bin
echo "[Maxtor]\npath="$hd"\nbrowseable=yes\nread only=no" | sudo tee -a /etc/samba/smb.conf

#add user to smb
echo "Adding user 'pi' to samba, please create a password for pi"
sudo smbpasswd -a pi
sudo service smbd restart

#installing transmission
sudo apt-get install -y transmission-daemon
sudo service transmission-daemon stop
echo "Transmission installed. Please update username, password and download_dir using cmd sudo vim /etc/transmission-daemon/settings.json"

#install gphoto for capturing shots with DSLR
sudo apt-get install gphoto2 python3-pip


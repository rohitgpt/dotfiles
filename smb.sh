hd=/home/pi/Maxtor
#configuring samba 
sudo apt-get install samba samba-common-bin
echo "[Maxtor]\npath="$hd"\nbrowseable=yes\nread only=no" | sudo tee -a /etc/samba/smb.conf

#add user to smb
echo "Adding user 'pi' to samba, please create a password for pi"
sudo smbpasswd -a pi
sudo service smbd restart

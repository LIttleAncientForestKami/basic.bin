#!/bin/bash

# Very basic backup-info gathering script
# Thanks to Ubuntu Forums supermod OldFred for most of hardware stuff
# http://ubuntuforums.org/showthread.php?t=1748541

mkdir backup-info
cd backup-info

# hardware
sudo lshw -html > hardware_info.html
sudo udevadm info --export-db > udevDB.txt
sudo dmidecode > bios.txt

# boot and MBR
# http://sourceforge.net/projects/bootinfoscript/ if you don't have it
sudo bash ~/bin/bootscript/bootinfoscript
mv ~/bin/bootscript/RESULTS.txt .
# This creates RESULTS.txt with MBR/Grub/partition information. 

# software installed
sudo apt-clone clone apt-clone-state-ubuntu-$(lsb_release -sr)-$(date +%F).tar.gz

# restore: sudo apt-clone restore apt-clone-state-ubuntu.tar.gz
# sudo apt-clone restore-new-distro apt-clone-state-ubuntu.tar.gz $(lsb_release -sc)

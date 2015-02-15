#!/bin/bash
#  file: post-installation.sh
# autor: frep
###################################################################################
# paths and variables
###################################################################################

setupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


###################################################################################
# functions
###################################################################################

function assertLaunchStartxScriptExists {
	if [ ! -f ~/launchAtStartx.sh ]; then
    		# script does not exist yet. Create it!
    		cp ${setupdir}/system/launchAtStartx.sh ~/
  	fi
  	if [ ! -f ~/.config/autostart/launchAtStartx.desktop ]; then
		if [ ! -d ~/.config/autostart ]; then
			mkdir ~/.config/autostart
		fi
    		# launchAtStartx.desktop does not exist yet. Create it!
    		cp -f ${setupdir}/system/launchAtStartx.desktop ~/.config/autostart/
  	fi
}

function setKeyboardlayout {
  	sudo dpkg-reconfigure keyboard-configuration
}

function setTimezone {
  	sudo dpkg-reconfigure tzdata
}

function updateAndUpgrade {
	sudo apt-get update && sudo apt-get upgrade -y
}

function installBasics {
	sudo apt-get install nano -y
}

function useOwnBashRc {
	cp ${setupdir}/system/.bashrc ~/.bashrc
}

function installConky {
	sudo apt-get install conky -y
	cd
	if [ ! -d .conky ]; then
		mkdir .conky
	fi
	cp ${setupdir}/conky/.conkyrc .conky/
	cp ${setupdir}/conky/conkyTemp.py .conky/
}

function startConkyAtStartx {
	assertLaunchStartxScriptExists
	cat ~/launchAtStartx.sh | sed '/^exit 0/d' > tmpFile
	echo "# CONKY" >> tmpFile
	echo "killall conky" >> tmpFile
	echo "sleep 5" >> tmpFile
	echo "conky --config=.conky/.conkyrc -d &" >> tmpFile
	echo "" >> tmpFile
	echo "exit 0" >> tmpFile
	sudo mv tmpFile ~/launchAtStartx.sh
	sudo chmod +x ~/launchAtStartx.sh
}


###################################################################################
# program
###################################################################################

#setKeyboardlayout
#setTimezone
#updateAndUpgrade
#installBasics
#useOwnBashRc
#installConky
#startConkyAtStartx

###################################################################################
# reminders (not scripted)
###################################################################################

# RESIZE ROOTFS
# sudo fdisk -l shows for rootfs:
# /dev/mmcblk0p2          264192    14600191     7168000   83  Linux
# rewrite partition table, using fdisk:
# sudo fdisk /dev/mmcblk0
# delete actual partition 2 and make a new primary partion 2 with full size
# and apply changes
# d 2 n p 2 \n \n w
# reboot: sudo shutdown -r now
# resize rootfs: sudo resize2fs /dev/mmcblk0p2

# NEW USER
# create new user with "sudo adduser <newUser>"  (not useradd ...)
# use "sudo addgroup <newUser> <group>" for the following groups:
# adm dialout cdrom audio dip video plugdev admin

# AUTOLOGIN FREP IN XFCE
# change /etc/lxdm/default.conf:
# autologin=frep
# session=/usr/bin/startxfce4

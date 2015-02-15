#!/bin/bash
#  file: post-installation.sh
# autor: frep
###########################################################################
# paths and variables
###########################################################################

setupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


###########################################################################
# functions
###########################################################################

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


###########################################################################
# program
###########################################################################

#setKeyboardlayout
#setTimezone
#updateAndUpgrade
#installBasics
#useOwnBashRc
#installConky

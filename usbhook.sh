#!/bin/bash
#################################################
#						#
# Automatic copy on usb drive when plugged !	#
#                      	    Célestin PREAULT	#
#						#
#################################################

# Please add that command in /etc/udev/rules.d/99-usbhook.rules to run script when a usb drive is plugged in
#
#	ACTION=="add",KERNEL=="sd*", SUBSYSTEMS=="usb", ATTRS{product}=="*", RUN+="/home/stf/usbhook.sh %k"
#
#	(Change run command according to the location of that script)
#
#	run that command to update udev rules :  sudo udevadm control --reload-rules
#
################################################################################################################

# CONFIGURATION
LOG_FILE=/var/log/usbhook
exec > >(tee -a ${LOG_FILE} )
exec 2> >(tee -a ${LOG_FILE} >&2)

# CONFIGURATION: Source folder
SRC="/home/stf/usb_source"

DEVICE="$1" # the device name

NUMBER="${DEVICE: -1}"


if [ "$NUMBER" = "1" ]
then
	exit 0
fi

mkdir /tmp/"$DEVICE"

# Mount ntfs usb drive
mount -t ntfs-3g /dev/"$DEVICE"1 /tmp/"$DEVICE"

cp -R "$SRC"/* /tmp/"$DEVICE"
chmod 777 -R /tmp/"$DEVICE"

umount /tmp/"$DEVICE"
rm -r /tmp/"$DEVICE"

echo "Copie vers $DEVICE effectuée !"

export DISPLAY=:0
sudo -u stf notify-send "Copie vers $DEVICE effectuée !" -t 5000

exit 0

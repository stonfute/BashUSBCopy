# BashUSBCopy

Bash script to automatically copy file on USB drives when it's plugged on USB port.
Used to make massive copies of files on usb drives (usb drives gifted during conference).


Features : 
---------
* Automatic launch when an USB drive is plugged in
* Automatic mount of ntfs USB drive (can be manualy changed to non ntfs partition)
* Automatic copy of a whole folder (including sub-folders, keeping the hierachy)
* Automatic notification on the desktop when copy is done (using notify-send)
* Automatic umount after copy
* Support multiple USB drives at the same time (`usbhook.sh` is called each time)


Setup :
-----------

Please add that command in `/etc/udev/rules.d/99-usbhook.rules` to run script when an usb drive is plugged in
`ACTION=="add",KERNEL=="sd*", SUBSYSTEMS=="usb", ATTRS{product}=="*", RUN+="/home/stf/usbhook.sh %k"`
(Change run command according to the location of that script)

Run `sudo udevadm control --reload-rules` to update udev rules

Create log file (according to the configuration in usbhook.sh) > `sudo touch /var/log/usbhook`

### In usbhook.sh :
* Edit the path `SRC` (line 25) according to the source folder that you want to copy on usb drives
* Edit the `mount` command (line 40) if you don't want to use ntfs partition
* Edit the user `stf` by your own username in `sudo` command at line 51 if you want to see notification on desktop

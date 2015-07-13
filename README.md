# cmupdater

#Changelog: 

0.2:

Added function to check if update-files are already present in the specified directory.

Implemented MD5 checksums for the updates.

#WHAT IS THIS?

This script will compare the currently installed CyanogenMod-version on your phone 
with the newest one available for your device and automatically download available updates 
and their MD5-hash, which then get automatically installed in your recovery. 
It also backs up your /system, /data and /boot-partitions and moves the backup to your PC (requires TWRP). 
You'll get prompted at every step. 

If you only want the downloader/backup-tool, look here: https://github.com/heavyhdx/cmdownloader

#REQUIREMENTS:

Your phone needs to be connected to your PC via USB. 

Android ADB-tools have to be installed and set up properly (meaning globally available on Windows). 

USB-debugging and ADB root-permissions must be enabled (you can do that in the Developer-Options). 

On Windows you need to make sure that your drivers are working properly, both in the system and in the recovery and you need Cygwin. 

You NEED TWRP for installing the .zip remotely on your phone and making backups. 

DO NOT unplug your device at any part of the process.


#HOW TO USE:

It works with every phone that is supported by official CyanogenMod-updates, you just need to replace my device-information in the cmupdater.sh file with yours and run the file via the terminal.

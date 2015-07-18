# cmUpdater v0.3

#What is this?

This is a Bash-script that allows you to backup, restore and update your CyanogenMod-device from your PC

#Features

-Works with every device that is officialy supported by CyanogenMod

-Checks for available updates by comparing the CyanogenMod-verison on your device with the newest one available

-If the latest CyanogenMod-update version differs from that on your device, you'll get an error to prevent you from getting the wrong files (for example flashing CM11 over CM12)

-Downloads the update

-Creates a backup of /system, /data and /boot and moves it to your PC (TWRP required, can be altered to include other partitions)

-Restores said update from your PC

-Automatic installation of the downloaded update (TWRP required)

-MD5-generation and verification for backups and updates in TWRP

-Path of work environment can be changed

-Asks you exactly what you want to do

#Requirements

-Your device needs to be connected to your PC via USB

-Android ADB-tools have to be installed and set up properly (meaning globally available on Windows)

-USB-debugging and must be enabled (you can do that in the Developer-Options)

-On Windows you need to make sure that your drivers are working properly, both in the system and in the recovery

-You need Cygwin to run this on Windows

-You NEED TWRP for installing the .zip remotely on your device and making backups

-DO NOT unplug your device at any part of the process

#Limitations

-This can only download the latest nightly of the highest version of CM that is available on your device, in other words the top file from your device's CyanogenMod-website (e.g. https://download.cyanogenmod.org/?device=victara)

-TWRP names the backup-folder differently for every single device (the path is /sdcard/TWRP/BACKUPS/RandomDeviceID/) so I have to delete BACKUPS/ to make sure there's no backup already there.
That means that if you have other backups there, they will be removed! So make sure you save them before running this, if you have any.

-Same thing with the backup-folder in your specified directory on your PC:
It will get deleted if you pull a new backup from your device, so if you want to keep old backups you'll have to move them to another location.

#How to use

Make sure you meet all requirements and then replace my device-information in the cmupdater.sh file with yours, set all options to your liking and then and run the file via the terminal

#Changelog

v0.1:

-Initial release

v0.2:

-Added function to check if update-files are already present in the specified directory

-Implemented MD5 checksums for the updates

v0.3:

-Added restore-option for backups

-Completely changed the way functions are called (used to be a chain where all functions called other functions, now it's a menu). 
 This also allows for much simpler implementation of new features and changes in the future.

-Deleted the cmDownloader-project and implemented all features into this one

# -

Obligatory "I'm not responsible if you fry your device". I have tested this thoroughly with various different devices (victara, condor, m7) but there can still be problems I'm not aware of, even if it seems unlikely.

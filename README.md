# cmUpdater

#What is this?

This is a Bash-script that allows you to update and backup your CyanogenMod-device from your PC

#Features

-Works with every device that is officialy supported by CyanogenMod

-Checks for available updates by comparing the CyanogenMod-verison on your device with the newest one available

-If the latest CyanogenMod-update version differs from that on your device, you'll get an error to prevent you from getting the wrong files (for example flashing CM11 over CM12)

-Downloads the update

-Creates a backup of /system, /data and /boot and moves it to your PC (TWRP required, can be altered to include other partitions)

-Automatic installation of the downloaded update (TWRP required)

-MD5-generation and verification in TWRP

-Path of work environment can be changed

-Prompts you at every step of the way


If you only want to download updates and backup your device, look here: https://github.com/heavyhdx/cmdownloader

#Requirements

-Your device needs to be connected to your PC via USB

-Android ADB-tools have to be installed and set up properly (meaning globally available on Windows)

-USB-debugging and must be enabled (you can do that in the Developer-Options)

-On Windows you need to make sure that your drivers are working properly, both in the system and in the recovery

-You need Cygwin to run this on Windows

-You NEED TWRP for installing the .zip remotely on your device and making backups

-DO NOT unplug your device at any part of the process

#Limitations

-Currently this can only download the latest nightly of the highest version of CM that is available on your device, in other words the top file from your device's CyanogenMod-website (e.g. https://download.cyanogenmod.org/?device=victara)

#How to use

Make sure you meet all requirements and then replace my device-information in the cmupdater.sh file with yours and run the file via the terminal

#Changelog

v0.1:

-Initial release

v0.2:

-Added function to check if update-files are already present in the specified directory

-Implemented MD5 checksums for the updates

# -

Obligatory "I'm not responsible if you fry your device". I have tested this thoroughly with various different devices (victara, condor, m7) but there can still be problems I'm not aware of, even if it seems unlikely.

#!/bin/bash

DEVICE=victara #Put your Device-ID here, for example 'hammerhead' for Nexus 5 (without quotes)

CMVERSION=12.1 #The CyanogenMod-Version you'd like to search for. Example: '11' (without quotes). 
#Note: If the version you put here differs from the version on your device, 
#you'll get an error to protect your device.

FILEPATH=./ #The path where the script will download CyanogenMod and store your backup.
#If you leave './', everything will go in the directory in which the script is located. 
#The script will automatically check if the update is already present in the specified directory,
#in case you had to abort the process after the download completed. 

#You NEED to make sure your path ends with '/' !



#------------------------------------------------------------------------------------------------------




ADB=$(adb shell grep -o ${CMVERSION}'-........-NIGHTLY-'${DEVICE} /system/build.prop | head -n1) 
#Reads the currently installed CM-version from your device's /system/build.prop. 

CURL=$(curl -s 'https://download.cyanogenmod.org/?device='${DEVICE} | grep -o ${CMVERSION}'-........-NIGHTLY-'${DEVICE} | head -n1 | grep ${CMVERSION}'-........-NIGHTLY-'${DEVICE} ) 
#Searches the CyanogenMod-website of your device for the latest update.

MD5=$(curl -s 'https://download.cyanogenmod.org/?device='${DEVICE} | grep -o 'md5sum: ................................' | cut -c 8-40 | head -n1) 
#Gets the md5-hash for the latest update

WGETURL=$(curl -s 'https://download.cyanogenmod.org/?device='${DEVICE} | grep -v 'jen' | grep -o -m1 'http://get.cm/get/...' | head -n1) 
#Selects the most recent direct-link to the CyanogenMod-zip



versionVerifier(){
	if [[ -n ${ADB} ]]; then
		echo 'Your current CyanogenMod-version is' $ADB 
		updateChecker
	else
		echo 'error: Your specified CyanogenMod-version and the device-version differ, or your device is not connected properly. Exiting'
		exit
	fi
}


updateChecker(){
	if [[ ${ADB} < ${CURL} ]]; then
		read -p "An updated version is available (cm-$CURL). Do you want to download it? (y/n/a)" -n 1 -r
		echo 
			if [[ $REPLY =~ ^[Yy]$ ]]; then
    				updateDownloader
			else
				echo 'Exiting...'
				exit
			fi
	else	
		echo No update available
	fi
}

updateDownloader(){
	if [ -f "${FILEPATH}cm-${CURL}.zip" ]; then
		read -p "Update found at ${FILEPATH} (cm-${CURL}.zip). Do you want to reboot your device into recovery and install it? (y/n/a)" -n 1 -r
		echo 
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			cmUpdater
		else
			echo 'Exiting...'
			exit
		fi
	else
		mkdir -p ${FILEPATH}
		updateDownloader2
	fi
}

updateDownloader2(){
wget ${WGETURL} -O "${FILEPATH}cm-${CURL}.zip"
echo ${MD5} > "${FILEPATH}cm-${CURL}.zip.md5"
read -p "Update downloaded. Do you want to reboot your device into recovery and install it? (y/n/a)" -n 1 -r
echo 
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    		cmUpdater
	else
		echo 'Exiting. Your update is located at' ${FILEPATH}
	fi
}

cmUpdater(){
adb reboot recovery
echo 'Waiting for device...'
sleep 30
read -p "Do you want to create a backup of your current system? This may take very long. (y/n/a)" -n 1 -r
echo 
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		adb shell twrp backup SDB
    		twrpBackupremover
	fi
	if [[ $REPLY =~ ^[Nn]$ ]]; then
		cmUpdater1
	fi
	if [[ $REPLY =~ ^[Aa]$ ]]; then
		echo 'Exiting...'
	fi
}

twrpBackupremover(){
	if [ -d ${FILEPATH}'/backup' ]; then
		read -p "Old backups found on your PC. Do you want to remove them? (y/n/a)" -n 1 -r
		echo 
		if [[ $REPLY =~ ^[Yy]$ ]]; then
    			rm -r "${FILEPATH}backup/"
			echo 'Removed old backups.'
			twrpBackup
		fi
		if [[ $REPLY =~ ^[Nn]$ ]]; then
			twrpBackup
		fi
		if [[ $REPLY =~ ^[Aa]$ ]]; then
			echo 'Exiting...'
			exit
		fi
	else
		twrpBackup
	fi
}

twrpBackup(){
read -p "Backup finished. Do you want to copy it to your PC and remove it from the device? This also can take very long. (y/n/a)" -n 1 -r
echo 
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    		adb pull /sdcard/TWRP/BACKUPS/ "${FILEPATH}backup/"
		adb shell rm -r /sdcard/TWRP/BACKUPS/
		echo 'Moved backups to the PC and removed them from the device!'
		cmUpdater1
	fi
	if [[ $REPLY =~ ^[Nn]$ ]]; then 
		cmUpdater1
	fi
	if [[ $REPLY =~ ^[Aa]$ ]]; then
		echo 'Exiting...'
		exit
	fi
}

cmUpdater1(){
echo 'Pushing cm-'${CURL}'.zip and its MD5 to your device...'
adb push "${FILEPATH}cm-${CURL}.zip" /sdcard/
adb push "${FILEPATH}cm-${CURL}.zip.md5" /sdcard/
adb shell twrp install /sdcard/cm-${CURL}.zip
adb shell rm /sdcard/cm-${CURL}.zip
adb shell rm /sdcard/cm-${CUR}L.zip.md5
read -p "Installation finished. Do you want clear cache and dalvik-cache? (y/n/a)" -n 1 -r
echo 
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		adb shell twrp wipe cache
		adb shell twrp wipe dalvik
		rebooter
	fi
	if [[ $REPLY =~ ^[Nn]$ ]]; then
		rebooter
	fi
	if [[ $REPLY =~ ^[Aa]$ ]]; then
		echo 'Exiting...'
	fi
}

rebooter(){
read -p "All done. Do you want to reboot your device now? (y/n/a)" -n 1 -r
echo 
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		adb reboot
		echo 'Rebooting. Have a nice day!'
	else
		echo 'Exiting. Have a nice day!'
		exit
	fi
}

versionVerifier

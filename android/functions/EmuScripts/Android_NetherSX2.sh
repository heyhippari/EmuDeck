#!/bin/bash

function Android_NetherSX2_install(){
	setMSG "Installing NetherSX2"
	temp_url="https://github.com/Trixarian/NetherSX2-patch/releases/download/1.8/NetherSX2-builder.zip"
	temp_emu="nethersx2"
	Android_download "$temp_emu.zip" $temp_url
	unzip "$temp_emu.zip"
	rm -rf "$Android_folder\$temp_emu.zip"
	chmod +x $Android_folder\builder\build-nethersx2.sh
	$Android_folder\builder\build-nethersx2.sh
	Android_ADB_installAPK "$HOME\emudeck\android\builder\PatchedAPK\15210-v1.5-4248-noads.apk"
}

function Android_NetherSX2_init(){
	echo "NYI"
}

function Android_NetherSX2_setup(){
	setMSG "NETHERSX2"
	adb shell pm grant xyz.aethersx2.android.permission.WRITE_EXTERNAL_STORAGE
	adb shell am start -n xyz.aethersx2.android/.MainActivity
	zenity --info --text="Waiting for user action..."
	adb shell am force-stop xyz.aethersx2.android
}

function Android_NetherSX2_IsInstalled(){
	package="xyz.aethersx2.android"
	test= adb shell pm list packages $package
	if [ $test == "true" ]; then
		echo "true"
	else
		echo "false"
	fi
}
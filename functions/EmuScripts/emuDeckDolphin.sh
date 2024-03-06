#!/bin/bash
#variables
Dolphin_emuName="Dolphin"
Dolphin_emuType="$emuDeckEmuTypeFlatpak"
Dolphin_emuPath="org.DolphinEmu.dolphin-emu"
Dolphin_configFile="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Dolphin.ini"
Dolphin_configFileGFX="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/GFX.ini"
Dolphin_gamecubeFile="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/GCPadNew.ini"
Dolphin_releaseURL=""

#cleanupOlderThings
Dolphin_cleanup(){
    #backup old Dolphin input profiles, if the user wants to keep them
    #wii
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-GyroAccelTouch.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-GyroAccelTouch.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-PkmBtlRev.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-PkmBtlRev.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-Touch+Joy.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-Touch+Joy.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-xbox.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/SD-xbox.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stdxbox.ini"  "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stdxbox.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb2.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb2.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb3.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb3.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb4.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/steamxb4.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stock with mouse.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stock with mouse.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stock.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/stock.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/wiigalaxy.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/Wiimote/wiigalaxy.ini.old"
    #GC
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/base.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/base.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam1.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam1.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam2.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam2.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam3.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam3.ini.old"
    mv "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam4.ini" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Profiles/GCPad/steam4.ini.old"
    echo "Old EmuDeck profiles, if they existed backed up to .bak"
}

#Install
Dolphin_install(){
  setMSG "${Dolphin_emuName}: Install"
  echo ""
	installEmuFP "${Dolphin_emuName}" "${Dolphin_emuPath}"
}

#ApplyInitialSettings
Dolphin_init(){
  
  setMSG "${Dolphin_emuName}: Apply initial config"
  echo ""
	configEmuFP "${Dolphin_emuName}" "${Dolphin_emuPath}" "true"
	Dolphin_setupStorage
	Dolphin_setEmulationFolder
	Dolphin_setupSaves
  Dolphin_cleanup
  Dolphin_setCustomizations
	SRM_createParsers
    #Dolphin_DynamicInputTextures
}

#update
Dolphin_update(){
  setMSG "${Dolphin_emuName}: Apply configuration Update"
  echo ""
	configEmuFP "${Dolphin_emuName}" "${Dolphin_emuPath}"
	Dolphin_setupStorage
	Dolphin_setEmulationFolder
	Dolphin_setupSaves
  Dolphin_cleanup
}

#ConfigurePaths
Dolphin_setEmulationFolder(){
    setMSG "${Dolphin_emuName}: Configure Emulation folder"
    echo ""
  	local configFile="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/Dolphin.ini"
    gameDirOpt1='ISOPath0 = '
    gameDirOpt1Setting='ISOPath0 = '"${romsPath}/gamecube"
    gameDirOpt2='ISOPath1 = '
    gameDirOpt2Setting='ISOPath1 = '"${romsPath}/wii"
    sed -i "/${gameDirOpt1}/c\\${gameDirOpt1Setting}" "$configFile"
    sed -i "/${gameDirOpt2}/c\\${gameDirOpt2Setting}" "$configFile"
}

#SetupSaves
Dolphin_setupSaves(){
    setMSG "${Dolphin_emuName}: setup Saves folder"
    echo ""
    unlink "$savesPath/dolphin/states"
	linkToSaveFolder dolphin GC "$HOME/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/GC"
	linkToSaveFolder dolphin Wii "$HOME/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Wii"
	linkToSaveFolder dolphin StateSaves "$HOME/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/StateSaves"
}


#SetupStorage
Dolphin_setupStorage(){

  if [ -d "${HOME}/.local/share/Steam" ]; then
    STEAMPATH="${HOME}/.local/share/Steam"
  elif [ -d "${HOME}/.steam/steam" ]; then
    STEAMPATH="${HOME}/.steam/steam"
  else
    echo "Steam install not found"
  fi

  if [[ -L "$romsPath/gc" && ! $(readlink -f "$romsPath/gc") =~ ^"$romsPath" ]] || [[ -L "$romsPath/gamecube" && ! $(readlink -f "$romsPath/gamecube") =~ ^"$romsPath" ]]; then
      echo "User has symlinks that don't match expected paths located under $romsPath. Aborting symlink update."
  else
    if [[ ! -e "$romsPath/gamecube" && ! -e "$romsPath/gc" ]]; then
      mkdir -p "$romsPath/gc"
      ln -sfn "$romsPath/gc" "$romsPath/gamecube"
    elif [[ -d "$romsPath/gamecube" && -L "$romsPath/gc" ]]; then
      echo "Converting gc symlink to a regular directory..."
      unlink "$romsPath/gc"
      mv "$romsPath/gamecube" "$romsPath/gc"
      ln -sfn "$romsPath/gc" "$romsPath/gamecube"
      echo "gamecube symlink updated to point to gc"
    elif [[ -d "$romsPath/gamecube" && ! -e "$romsPath/gc" ]]; then
      echo "Creating gc directory and updating gamecube symlink..."
      mv "$romsPath/gamecube" "$romsPath/gc"
      ln -sfn "$romsPath/gc" "$romsPath/gamecube"
      echo "gamecube symlink updated to point to gc"
    elif [[ -d "$romsPath/gc" && ! -e "$romsPath/gamecube" ]]; then
      echo "gamecube symlink not found, creating..."
      ln -sfn "$romsPath/gc" "$romsPath/gamecube"
      echo "gamecube symlink created"
    fi
  fi

  find "$STEAMPATH/userdata" -name "shortcuts.vdf" -exec sed -i "s|${romsPath}/gc|${romsPath}/gamecube|g" {} +
}


#WipeSettings
Dolphin_wipe(){
   rm -rf "$HOME/.var/app/$Dolphin_emuPath"
   # prob not cause roms are here
}


#Uninstall
Dolphin_uninstall(){
    flatpak uninstall "$Dolphin_emuPath" --user -y
}

#setABXYstyle
Dolphin_setABXYstyle(){
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/A = `Button S`|Buttons/A = `Button E`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/B = `Button N`|Buttons/B = `Button S`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/X = `Button E`|Buttons/X = `Button N`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/Y = `Button W`|Buttons/Y = `Button W`|' $Dolphin_gamecubeFile

}

Dolphin_setBAYXstyle(){
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/A = `Button E`|Buttons/A = `Button S`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/B = `Button S`|Buttons/B = `Button N`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/X = `Button N`|Buttons/X = `Button E`|' $Dolphin_gamecubeFile
   	sed -i '/^\[GCPad1\]/,/^\[/ s|Buttons/Y = `Button W`|Buttons/Y = `Button W`|' $Dolphin_gamecubeFile
}

#Migrate
Dolphin_migrate(){
   	echo "NYI"
}

#WideScreenOn
Dolphin_wideScreenOn(){
    setMSG "${Dolphin_emuName}: Widescreen On"
    echo ""
    configFile="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/GFX.ini"
    wideScreenHack='wideScreenHack = '
    wideScreenHackSetting='wideScreenHack = True'
    aspectRatio='AspectRatio = '
    aspectRatioSetting='AspectRatio = 1'
    sed -i "/${wideScreenHack}/c\\${wideScreenHackSetting}" "$configFile"
	sed -i "/${aspectRatio}/c\\${aspectRatioSetting}" "$configFile"
}

#WideScreenOff
Dolphin_wideScreenOff(){
    setMSG "${Dolphin_emuName}: Widescreen Off"
    echo ""
    local configFile="$HOME/.var/app/org.DolphinEmu.dolphin-emu/config/dolphin-emu/GFX.ini"
    wideScreenHack='wideScreenHack = '
    wideScreenHackSetting='wideScreenHack = False'
    aspectRatio='AspectRatio = '
    aspectRatioSetting='AspectRatio = 0'
    sed -i "/${wideScreenHack}/c\\${wideScreenHackSetting}" "$configFile"
	sed -i "/${aspectRatio}/c\\${aspectRatioSetting}" "$configFile"
}

#BezelOn
Dolphin_bezelOn(){
echo "NYI"
}

#BezelOff
Dolphin_bezelOff(){
echo "NYI"
}

Dolphin_IsInstalled(){
    isFpInstalled "$Dolphin_emuPath"
}

Dolphin_resetConfig(){
	Dolphin_init &>/dev/null && echo "true" || echo "false"
}
#finalExec - Extra stuff
Dolphin_finalize(){
	echo "NYI"
}


Dolphin_DynamicInputTextures(){
  local DIT_releaseURL="$(getLatestReleaseURLGH "Venomalia/UniversalDynamicInput" "7z")"

  if [[ ! -e "$storagePath/dolphin/Load" ]]; then
    mkdir -p "$storagePath/dolphin/Load"
    ln -s "$HOME/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Load/" "$storagePath/dolphin/Load/"
  fi

  if safeDownload "UniversalDynamicInput" "$DIT_releaseURL" "$HOME/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu/Load/DynamicInputTextures.7z" "false"; then
    7z "$storagePath/dolphin/Load/DynamicInputTextures.7z" -o"$storagePath/dolphin/Load/" && rm -rf "$storagePath/Dolphin/Load/DynamicInputTextures.7z"
  else
    return 1
  fi
}

Dolphin_setCustomizations(){
    if [ "$arDolphin" == 169 ]; then
      Dolphin_wideScreenOn
    else
      Dolphin_wideScreenOff
    fi
}

Dolphin_setResolution(){
	case $dolphinResolution in
		"720P") multiplier=2;;
		"1080P") multiplier=3;;
		"1440P") multiplier=4;;
		"4K") multiplier=6;;
		*) echo "Error"; return 1;;
	esac

	RetroArch_setConfigOverride "InternalResolution" $multiplier "$Dolphin_configFileGFX"
}

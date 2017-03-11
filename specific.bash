#### ENV VARS ####

# Enlistment directories
ENLISTMENT_CDP="$F/enlistments/onecoreuap/windows/cdp"
ENLISTMENT_APP_CONTRACT="$F/enlistments/onecoreuap/base/appmodel/AppContracts"

# Git Repo locations of importanace
COA="$C/git_repos/CortanaAndroid"
TDD="$C/git_repos/cdp/build/onecorefast/x64/debug/tests"
ROMAN="$C/git_repos/cdp/samples/romanapp/android"
XAMARIN="$C/git_repos/project-rome/xamarin"
XAMARIN_APK="$XAMARIN/samples/ConnectedDevices.Xamarin.Droid.Sample/ConnectedDevices.Xamarin.Droid.Sample/bin/x86/Debug"
XAMARIN_DLL="$XAMARIN/src/ConnectedDevices.Xamarin.Droid/bin/x86/Debug"
ROME_INTERN_APK="$ROMAN/internal/build/outputs/apk"

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI_CDP/"
ANPEA_DIR="//redmond/osg/release/DEP/CDP/anpea"
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners/Rome_1701"

# Note files directories
NOTES="$C/notes/"

# Application directories
MY_JAVA_HOME="$C/Program\ Files/Java/jdk1.8.0_121"
JAVAC="$MY_JAVA_HOME/bin/javac.exe"
JAVAP="$MY_JAVA_HOME/bin/javap.exe"
VS="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7/IDE/devenv.exe"

# Local log directories
SYS_CDP_WIN="\"C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform\""
USER_CDP_WIN="\"C:\\Users\\anpea\\AppData\\Local\\ConnectedDevicesPlatform\""

#### CD ALIASES ####

alias cdp1="cd $CDP_1"
alias cdp2="cd $CDP_2"
alias master="cd $CDP_MASTER"
alias xamarin="cd $XAMARIN"
alias xamarin_apk="cd $XAMARIN_APK"
alias xamarin_dll="cd $XAMARIN_DLL"
alias en_cdp="cd $ENLISTMENT_CDP"
alias en_appservice="cd $ENLISTMENT_APP_CONTRACT"
alias coa="cd $COA"
alias tdd="cd $TDD"
alias romanapp="cd $ROMAN"
alias rome_intern_apk="cd $ROME_INTERN_APK"
alias work="cd $WORK"
alias notes="cd $NOTES"
alias l2="cd $CDP_WIN10"
alias l2cdp="cd $CDP_WIN10/onecoreuap/windows/cdp"
alias vms="cd $VM_DIR"
alias log_dir="cd $SYS_CDP_WIN"
alias user_log_dir="cd $USER_CDP_WIN"
alias anpea_dir="cd $ANPEA_DIR"
alias rome_drop="cd $ROME_DROP"
alias coa_builds="cd $COA_BUILDS"
alias cygwin="cd $CYGWIN"

#### PROGRAM ALIASES ####

alias adb="$ADB"
alias subl="$SUBL_ALIAS"
alias javac="$JAVAC"
alias javap="$JAVAP"
alias scons="$C/Python27/scons-2.4.1.bat "
alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "

alias bashrc="$SUBL_ALIAS .bashrc"
alias xbashrc="$SUBL_ALIAS $X/.bashrc"

#### CDP Traces ####

# Note: Requires Admin
stopsvc() { sc stop cdpsvc; }
startsvc() { sc start cdpsvc; }
disablesvc() { sc config cdpsvc start=disabled; }
enablesvc() { sc config cdpsvc start=demand; }

alias rm_sys_log="stopsvc && rm $SYS_CDP_WIN\\\\CDPTraces.log && startsvc"
alias rm_user_log="rm $USER_CDP_WIN\\\\CDPTraces.log"

alias sys_log="$SUBL_ALIAS $SYS_CDP_WIN\\\\CDPTraces.log"
alias user_log="$SUBL_ALIAS $USER_CDP_WIN\\\\CDPTraces.log"

#### Creating CoA Drop Script - Private Functions ####

# Generate Date Time Stamp - MM.DD.YYYY
_dts2 () { date +%m.%d.%Y; }

# Create a directory with timestamp
_make_drop_dirs () { CURR_DROP="$ROME_DROP/$(_dts2)"; export CURR_DROP; mkdir $CURR_DROP; mkdir "$CURR_DROP\armv7"; mkdir "$CURR_DROP\armv7\symbols"; }

_cp_arr_external () { cp "$CDP_1/$1/android/build/outputs/aar/connecteddevices-$1-armv7-internal-$2.aar""$ROME_DROP/$(_dts2)/armv7/connecteddevices-$1-armv7-internal-$2.aar"; }
_cp_arrs_external () { $(_cp_arr_external core debug); $(_cp_arr_external core release); $(_cp_arr_external sdk debug); $(_cp_arr_external sdk release); }

_cp_so_external () { cp "$CDP_1/core/android/build/intermediates/jniLibs/internal/release/armeabi-v7a/libCDP_internal.$1""$ROME_DROP/$(_dts2)/armv7/symbols/libCDP_internal.$1"; }
_cp_sos_external () { $(_cp_so_external so); $(_cp_so_external so.debug); }

_cp_so_java_external () { cp "$CDP_1/sdk/android/src/internalRelease/jniLibs/armeabi-v7a/libCDP_java_internal.$1""$ROME_DROP/$(_dts2)/armv7/symbols/libCDP_java_internal.$1"; }
_cp_sos_java_external () { $(_cp_so_java_external so); $(_cp_so_java_external so.debug); }

#### Creating CoA Drop Script - Public Function ####

drop_coa () { $(_make_drop_dirs) && $(_cp_arrs_external); $(_cp_sos_external); $(_cp_sos_java_external); }

#### Clearing / Moving build files ####

_cp_arr_in () { cp "$CDP_1/$1/android/build/outputs/aar/connecteddevices-$1-armv7-internal-release.aar""$COA/DSS/BuildDependencies/shared"; }

cp_arr () { $(_cp_arr_in sdk) && $(_cp_arr_in core) ; }

clean_android () { rm -rf "$CDP_1/core/android/build" && rm -rf "$CDP_1/sdk/android/build" && rm -rf "$CDP_1/samples/CDPHost/android/app/build";  }

clean_cdphost () { rm -rf "$CDP_1/samples/CDPHost/android/app/build";  }

clean_coa () { rm -rf "$COA/DSS/AuthLib/build"; }

aar () { cd "$CDP_1/sdk/android/3p/build/outputs/aar"; }

#### Download VM - Private Functions ####

# Print and go to the latest build directory with a VHD
_vm () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "$1/vhd/"]; then echo "$var : $1 exists"; break; fi; done; }

# After using `_vm` to navigate to the directory, copy the VHD to local drive
alias _cpvm="rsync -a --progress $1/vhd/vhd_client_enterprise_en-us_vl/* $C/VHDs/"

# After using `_vm` to navigate to the directory, copy the sfpcopy to local drive
alias _cpsfp="rsync -a --progress $1/bin/idw/sfpcopy.exe $C/VHDs/"

# Print and go to the latest build directory with a VHD containing a sfpcopy
_sfp () { for var in {1..10}; do cd $VM_DIR; ls | sort | tail -$var | head -1; cd `ls | sort | tail -$var | head -1`; if [ -d "$1/bin/idw/sfpcopy.exe" ]; then echo "$var : sfpcopy.exe exists"; break; fi; done; }

_64 () { $1 "amd64fre"; }

_86 () { $1 "x86fre"; }

#### Download VM - Public Functions ####

# go to the latest build directory
latest () { cd $VM_DIR; ls | sort | tail -1; cd `ls | sort | tail -1`; }

# go to the $1th latest build directory
vmn () { cd $VM_DIR; ls | sort | tail -$1 | head -1; cd `ls | sort | tail -$1 | head -1`; }

vm () { _64 _vm; }
vm86 () { _86 _vm; }

cpvm () { _64 _cpvm; }
cpvm86 () { _86 _cpvm; }

cpsfp () { _64 _cpsfp; }
cpsfp86 () { _86 _cpsfp; }

sfp () { _64 _sfp; }
# Note: Disabled due to broken
# sfp86 () { _86 _sfp; }
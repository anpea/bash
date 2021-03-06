#### ENV VARS ####

# Enlistment directories
ENLISTMENT_CDP="$F/enlistments/onecoreuap/windows/cdp"
ENLISTMENT_APP_CONTRACT="$F/enlistments/onecoreuap/base/appmodel/AppContracts"

# Git Repo locations of importanace
COA="$C/git_repos/CortanaAndroid"
TDD="$C/git_repos/cdp/build/onecorefast/x64/debug/tests"
ROMAN="$C/git_repos/cdp/samples/romanapp/android"
XAMARIN="$C/git_repos/project-rome/xamarin"

# APK locations
XAMARIN_APK="$XAMARIN/samples/ConnectedDevices.Xamarin.Droid.Sample/ConnectedDevices.Xamarin.Droid.Sample/bin/x86/Debug"
ROME_IN_APK="$ROMAN/internal/build/outputs/apk"
SDK_3P_AAR="$C/git_repos/cdp/sdk/android/3p/build/outputs/aar"
XAMARIN_DLL="$XAMARIN/src/ConnectedDevices.Xamarin.Droid/bin/x86/Debug"

# Network directories
VM_DIR="//winbuilds/release/RS_ONECORE_DEP_ACI_CDP/"
ANPEA_DIR="//redmond/osg/release/DEP/CDP/anpea"
ROME_DROP="//redmond/osg/release/dep/CDP/V3Partners/Rome_1701"
CURRENT_ROME_DROP="$ROME_DROP/Rome_1702"

# Note files directories
NOTES="$C/notes/"
BUG_FILES="$C/work_files/bug_files"

VM_SETTINGS="$WORK_WIN/vm_settings"
CMD_SETTINGS="$WORK_WIN/cmd.exe_settings"


# Application directories
MY_JAVA_HOME="$C/Program\ Files/Java/jdk1.8.0_121"
JAVAC="$MY_JAVA_HOME/bin/javac.exe"
JAVAP="$MY_JAVA_HOME/bin/javap.exe"
VS="$C/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 14.0/Common7/IDE/devenv.exe"

# Local log directories
SYS_CDP_WIN="\"C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\ConnectedDevicesPlatform\""
USER_CDP_WIN="\"C:\\Users\\anpea\\AppData\\Local\\ConnectedDevicesPlatform\""

SYS_CDP="$C/Windows/ServiceProfiles/LocalService/AppData/Local/ConnectedDevicesPlatform"
USER_CDP="$C/Users/anpea/AppData/Local/ConnectedDevicesPlatform"

OPEN_NAMES="\n\
- xam_apk\n\
- xam_dll\n\
- sdk_aar\n\
- rome_apk\n\
- cdpsvc\n\
- cdpusersvc\n\
- anpea_dir\n\
- rome_drop\n\
- xam_proj\n\
- coa\n\
- romanapp\n\
- work\n\
- notes\n\
- bugs\n\
- home\n\
- en\n\
- en_cdp\n\
- en_appservice
"

#### CD ALIASES ####

alias cdp1="cd $CDP_1"
alias cdp2="cd $CDP_2"
alias master="cd $CDP_MASTER"

_navigate()
{
    case $2 in
        # Build files
        xam_apk)       $1 $XAMARIN_APK && return 0;;
        xam_dll)       $1 $XAMARIN_DLL && return 0;;
        sdk_aar)       $1 $SDK_3P_AAR && return 0;;
        rome_apk)      $1 $ROME_IN_APK && return 0;;
        # System logs
        cdpsvc)        $1 $SYS_CDP && return 0;;
        cdpusersvc)    $1 $USER_CDP && return 0;;
        # Network
        anpea_dir)     $1 $ANPEA_DIR && return 0;;
        rome_drop)     $1 $ROME_DROP && return 0;;
        vms)           $1 $VM_DIR && return 0;;
        # Git repos
        xam_proj)      $1 $XAMARIN && return 0;;
        coa)           $1 $COA && return 0;;
        romanapp)      $1 $ROMAN && return 0;;
        # notes
        work)          $1 $WORK && return 0;;
        notes)         $1 $NOTES && return 0;;
        bugs)          $1 $BUG_FILES && return 0;;
        home)          $1 $CYGWIN && return 0;;
        # Enlistment
        en)            $1 "$F/enlistments" && return 0;;
        en_cdp)        $1 $ENLISTMENT_CDP && return 0;;
        en_appservice) $1 $ENLISTMENT_APP_CONTRACT && return 0;;
        * ) printf "Valid options are $OPEN_NAMES" && return 1;;
    esac
}

# Open a explorer window at the path name - op = OPen
op() { _navigate cygstart $1; }

# Change directory to path name - gt = Go To
gt() { _navigate cd $1; }

# Check Script
cs()
{
    case $1 in
        # Windows
        vm)       "$SUBL_FUNC" "$VM_SETTINGS/aliases.pub" && return 0;;
        cmd)      "$SUBL_FUNC" "$CMD_SETTINGS/aliases.pub" && return 0;;
        # Bash
        inputrc)  "$SUBL_FUNC"" $CYGWIN_WIN/.inputrc_custom"  && return 0;;
        android)  "$SUBL_FUNC" "$CYGWIN_WIN/android.bash"  && return 0;;
        general)  "$SUBL_FUNC" "$CYGWIN_WIN/general.bash"  && return 0;;
        git)      "$SUBL_FUNC" "$CYGWIN_WIN/git.bash"  && return 0;;
        main)     "$SUBL_FUNC" "$CYGWIN_WIN/main.bash"  && return 0;;
        shared)   "$SUBL_FUNC" "$CYGWIN_WIN/shared.bash"  && return 0;;
        specific) "$SUBL_FUNC" "$CYGWIN_WIN/specific.bash"  && return 0;;
        * ) printf "No valid alias option given." && return 1;;
    esac
}

#### PROGRAM ALIASES ####

alias adb="$ADB"
alias subl="$SUBL_ALIAS"
alias javac="$JAVAC"
alias javap="$JAVAP"
alias scons="$C/Python27/scons-2.4.1.bat "
alias err="//tkfiltoolbox/tools/839/1.7.2/x86/err "

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
_make_drop_dirs () { CURR_DROP="$CURRENT_ROME_DROP/$(_dts2)"; export CURR_DROP; mkdir $CURR_DROP; mkdir "$CURR_DROP\armv7"; mkdir "$CURR_DROP\armv7\symbols"; }

_cp_arr_external () { cp "$CDP_1/$1/android/build/outputs/aar/connecteddevices-$1-armv7-internal-$2.aar""$CURRENT_ROME_DROP/$(_dts2)/armv7/connecteddevices-$1-armv7-internal-$2.aar"; }
_cp_arrs_external () { $(_cp_arr_external core debug); $(_cp_arr_external core release); $(_cp_arr_external sdk debug); $(_cp_arr_external sdk release); }

_cp_so_external () { cp "$CDP_1/core/android/build/intermediates/jniLibs/internal/release/armeabi-v7a/libCDP_internal.$1""$CURRENT_ROME_DROP/$(_dts2)/armv7/symbols/libCDP_internal.$1"; }
_cp_sos_external () { $(_cp_so_external so); $(_cp_so_external so.debug); }

_cp_so_java_external () { cp "$CDP_1/sdk/android/src/internalRelease/jniLibs/armeabi-v7a/libCDP_java_internal.$1""$CURRENT_ROME_DROP/$(_dts2)/armv7/symbols/libCDP_java_internal.$1"; }
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

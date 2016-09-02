#!/bin/bash

# silver-train : A suite of tools to check your standalone Raspberry Pi
#                on the configuration side (ie. passwd file; etc.)
#
# Check that the user's shell is safe, ie. only intended
# users have an actual login shell in /etc/passwd

# This script tries its best to honor the 'exit code proposal'
#  http://tldp.org/LDP/abs/html/exitcodes.html
#  (=> TL;DR it says "Use codes 64..113, and 0 for success")
#
# My exit codes
# ---------------------------------------
# Exitcode  Meaning
#
# 0	    OK - /etc/passwd is safe
# 64        I/O_ERROR        not able to open/read file /etc/passwd
# 65	    NOT_COVERED      Some entries are missing the field for shell
# 66	    UNSAFE           the /etc/passwd users have known logon shells
# 67        UNSAFE_UNKNOWN - /etc/passwd users have unknown logon shells
# 68        VERSIONECHO      User supplied 'v' or '--version' request

myname="silver-train"
myver="0.0.1"
myorgdate="02-Sep-2016"
sysname="Raspberry Pi's"
userfile="/etc/passwd"

# If quietmode is 1, then the script will only communicate via
# exit codes. Nice for standalone action; perpetual checks (if
# this script is part of a cron task or similar situations)
quietmode=0

# Debug mode is a verbose mode that spits out the internal variable
# values. 
debugmode=0

function checkPwdFile() {
    # We want only 1 user to be able to log on interactively
    # (with a known logon shell)
    #
    # Unknown shell programs will be listed as violating the safety
    # Ie. exit code
    shellist=`cat $userfile | cut -d : -f 7 | sort | uniq`
    if [ $quietmode -gt 0 ]; then
	echo $shellist
    fi
}


#
while [[ $# -gt 0 ]]; do
    key="$1"
    # Single option arguments - no secondary parameters
    case $key in
	-v|--version)
	    echo "$myname $myver"
	    exit 68
	    ;;
	-h|--help)
	    echo "You are helped."
	    exit 0
	    ;;
	-q|--quiet)
            quietmode=1
	    ;;
	*)
	    echo "Unknown flag provided!"
	;;
    esac
    # Eat next parameter
    shift
done

if [
echo Flags now
echo "quietmode: $quietmode"
echo "------------"
# Check the ability to read the passwd file
if [ ! -f $userfile ]; then
    echo "Error! Not able to read the user file at /etc/passwd"
    exit 64
fi

# Get unique shells, and check for security requirements
echo "Following logon shells found on system:"
checkPwdFile

exit 0

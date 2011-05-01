#!/bin/sh

# this script check if if system packages are installed
# use with Debian and Redhat compatible (dpkg|yum)

# enter here the packages to check (space separed) 
# Debian-compatible
DEPENDDPKG="libjpeg62 libjpeg62-dev zlib1g zlib1g-dev" 
# Redhat-compatible
# add .x86_64 if needed
DEPENDYUM="libjpeg.i386 ilibjpeg-devel.i386 zlib.i386 zlib-devel.i386" 

# check user
if [ $(whoami) != "root" ]; then
   echo "Error check-env: you must be superuser root"
   kill $$
fi

# Debian-compatible
if [ -e /etc/debian_version ]; then
    for dep in $DEPENDDPKG
    do
        DPKG=$(dpkg -l $dep | awk 'NR==6')
        FLAG=$(echo $DPKG | awk '{print $1}')
        NAME=$(echo $DPKG | awk '{print $2}')
        if [ "$NAME" != "$dep" ] || [ "$FLAG" != "ii" ]; then
	    echo "Error check-env: $dep not installed!"
	    EXIT=1
        fi
    done
fi

# Redhat-compatible
if [ -e /etc/redhat-release ]; then
    for dep in $DEPENDYUM
    do
        YUM=$(yum list | grep $dep)
        FLAG=$(echo $YUM | awk '{print $3}')
        NAME=$(echo $YUM | awk '{print $1}')
        if [ "$NAME" != "$dep" ] || [ "$FLAG" != "installed" ]; then
	    echo "Error check-env: $dep not installed!"
	    EXIT=1
        fi
    done
fi

if [ "$EXIT" = "1" ]; then
   kill $$
fi

   echo "check-env: all dependencies are installed!"

exit 0

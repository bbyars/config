#! /bin/sh

URL=$1

FILENAME=$$.dmg
MOUNTPOINT=__$$__

wget -O $FILENAME --no-check-certificate $URL
hdiutil attach -mountpoint $MOUNTPOINT $FILENAME
cp -rf $MOUNTPOINT/*.app /Applications
hdiutil detach $MOUNTPOINT
rm $FILENAME


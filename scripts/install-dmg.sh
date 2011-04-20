#! /bin/sh

URL=$1

FILENAME=__download.dmg
MOUNTPOINT=__install-dmg__

wget -O $FILENAME --no-check-certificate $URL
hdiutil attach -mountpoint $MOUNTPOINT $FILENAME
cp -rf $MOUNTPOINT/*.app /Applications
hdiutil detach $MOUNTPOINT
rm $FILENAME


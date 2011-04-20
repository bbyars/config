#! /bin/sh

URL=$1
FILENAME=$(basename $URL | sed s/%20/\ /)

wget --no-check-certificate $URL
hdiutil attach -mountpoint install-dmg "$FILENAME"
cp -rf install-dmg/*.app /Applications
hdiutil detach install-dmg
rm "$FILENAME"


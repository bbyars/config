#! /bin/sh

URL=$1
FILENAME=$(basename $URL | sed s/%20/\ /)

mkdir install-zip
cd install-zip
wget $URL
unzip "$FILENAME"
mv -f *.app /Applications
cd ..
rm -rf install-zip


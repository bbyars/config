#! /bin/sh

URL=$1

FILENAME=__download.zip

wget -O $FILENAME --no-check-certificate $URL
unzip $FILENAME
cp -rf *.app /Applications
rm -rf *.app
rm $FILENAME


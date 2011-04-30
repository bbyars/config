#!/bin/sh

URL=$1

FILENAME=$$.tar.bz2

cd /Applications
wget -O $FILENAME --no-check-certificate $URL
tar xzvf $FILENAME
rm $FILENAME

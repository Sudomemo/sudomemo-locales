#!/bin/bash

if [ -z $1 ]; then
	echo "Usage: $0 <file to append to locale file, sans .po extension>"
	exit;
fi;

for file in $(ls */LC_MESSAGES/$1.po); do

cat $1 >> $file
echo "cat $1 >> $file";
done;

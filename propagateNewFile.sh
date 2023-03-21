#!/bin/bash

# For new translations, copies it into all the other folders to ready it for translation

usage() {
	echo "Usage: " $0 '<path to .po file>'
	exit
}

[ -z "$1" ] && usage

# Verify correct working directory

if [ ! -f $(basename $0) ]; then
	echo $0 "must be run from the root of the locales folder."
	exit 1
fi

# Verify input file exists

if [ ! -f $1 ]; then
	echo File $1 does not exist, exiting
	exit 1
fi

echo "Propagating $1..."

source_locale=$(dirname $1 | cut -d'/' -f1)

for i in $(ls | grep _); do
	if [[ -d $i/LC_MESSAGES && ! -f $i/LC_MESSAGES/$(basename $1) ]]; then
		cp -v $1 $i/LC_MESSAGES

		# Replace the locale inside the copied file
		sed -i "s/Language: $source_locale/Language: $i/" $i/LC_MESSAGES/$(basename $1)
	fi
done

echo 'Done!'

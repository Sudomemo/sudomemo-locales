#!/bin/bash

# if a locale file name is passed as an argument, use it
if [ $# -eq 1 ]; then
	LOCALE_FILE=$1
else
	LOCALE_FILE="*"
fi

if [ "$DO_SORT" = "true" ]; then
	DO_SORT=true
else
	DO_SORT=false
fi

for domain in $(ls en_US/LC_MESSAGES/$LOCALE_FILE.po|xargs -L1 basename); do
    for lang in $(echo ??_??); do
		# Don't sort unless we edit in the -s flag
		# This way we don't cause massive merge conflicts all the time
		if $DO_SORT; then
			echo "Cleaning and sorting $lang/LC_MESSAGES/$domain"
			msgcat -s --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
		else
			echo "Cleaning $lang/LC_MESSAGES/$domain"
			msgcat --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
		fi
    done
done

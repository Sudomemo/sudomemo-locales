#!/bin/bash

# If a locale file name is passed as an argument, use it
if [ $# -eq 1 ]; then
    LOCALE_FILE=$1
else
    LOCALE_FILE="*"
fi

# Set sorting flag
if [ "$DO_SORT" = "true" ]; then
    DO_SORT=true
else
    DO_SORT=false
fi

for domain in $(ls en_US/LC_MESSAGES/$LOCALE_FILE.po | xargs -L1 basename); do
    for lang in $(echo ??_??); do
        # Remove duplicates first using msguniq
        # echo "Removing duplicates from $lang/LC_MESSAGES/$domain"
        # msguniq --to-code=UTF-8 --no-wrap $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain

        # Clean and optionally sort
        if $DO_SORT; then
            echo "Cleaning and sorting $lang/LC_MESSAGES/$domain"
            msgcat -s --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
        else
            echo "Cleaning $lang/LC_MESSAGES/$domain"
            msgcat --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
        fi
    done
done

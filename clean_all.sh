#!/bin/bash

for domain in $(ls en_US/LC_MESSAGES/*.po|xargs -L1 basename); do
    for lang in $(echo ??_??); do
				# Don't sort unless we edit in the -s flag
				# This way we don't cause massive merge conflicts all the time
				# msgcat -s --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
				msgcat --to-code=UTF-8 --no-wrap --lang=$lang $lang/LC_MESSAGES/$domain -o $lang/LC_MESSAGES/$domain
    done
done

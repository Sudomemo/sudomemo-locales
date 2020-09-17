#!/bin/bash

echo "=== Untranslated (or identical) strings ==="

# you can pass a langcode to filter by language
# We exclude English variations from this
# e.g ./find_untranslated.sh ja_JP

if [ ! -z $1 ]; then
    LANGFILTER=$1
else
    LANGFILTER="."
fi

for lang in $(echo ??_?? |tr ' ' '\n' | grep -v "en_" |grep $LANGFILTER); do
    echo "===== $lang ====="
    echo
    for domain in $(ls en_US/LC_MESSAGES/*.po|xargs -L1 basename); do

        # Missing locale file?
        if [ ! -f $lang/LC_MESSAGES/$domain ]; then
            echo "Error: $lang/LC_MESSAGES/$domain is missing"
            exit 1;
        fi;
        RESULTS=$(diff --unchanged-line-format='%L' --old-line-format='' --new-line-format='' en_US/LC_MESSAGES/$domain $lang/LC_MESSAGES/$domain | sed '/^$/d' |grep -B1 msgstr | grep -Po "msgid..\K.+?(?=\")" | awk '{print "- " $1}')
        if [ ! -z "$RESULTS" ]; then
                echo "$lang/LC_MESSAGES/$domain:";
                echo "$RESULTS"
                echo
        fi;
    done
done
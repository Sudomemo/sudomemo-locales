#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "# sudomemo-locales Problem Finder"
echo "Scans for problems as well as untranslated (or identical) strings"
echo

# you can pass a langcode to filter by language
# We exclude English variations from this, needs to update so we can optionally include
# e.g ./find_untranslated.sh ja_JP

if [ ! -z $1 ]; then
    LANGFILTER=$1
else
    LANGFILTER="."
fi

for lang in $(echo ??_?? | tr ' ' '\n' | grep $LANGFILTER); do
    echo "## $lang"
    echo
    for domain in $(ls en_US/LC_MESSAGES/*.po | xargs -I{} basename {} .po); do

        # Missing locale file?
        if [ ! -f $lang/LC_MESSAGES/$domain.po ]; then
            echo "Error: $lang/LC_MESSAGES/$domain.po is missing"
            exit 1
        fi

        # Wrong text encoding?

        CHECK_ENCODING=$(file $lang/LC_MESSAGES/$domain.po | grep -Ev "(UTF-8|ASCII|empty)")

        if [ ! -z "$CHECK_ENCODING" ]; then
            echo "$lang/LC_MESSAGES/$domain.po has wrong encoding: should be detected as UTF-8, ASCII, or empty"
            file $lang/LC_MESSAGES/$domain.po
            exit 1
        fi

        # Invalid?

        msgfmt --check-format $lang/LC_MESSAGES/$domain.po -o - >/dev/null

        if [ $? -ne 0 ]; then
            echo "Check the formatting for $lang/LC_MESSAGES/$domain.po"
            exit 1
        fi

        # Missing/extra strings?

        ENG_MSGID_LIST=$(grep -Po "^msgid..\K.+?(?=\")" en_US/LC_MESSAGES/$domain.po | sort | uniq)
        NEW_MSGID_LIST=$(grep -Po "^msgid..\K.+?(?=\")" $lang/LC_MESSAGES/$domain.po | sort | uniq)

        COMPARE_MISSING=$(comm -23 <(echo "$ENG_MSGID_LIST") <(echo "$NEW_MSGID_LIST"))
        COMPARE_EXTRA=$(comm -23 <(echo "$NEW_MSGID_LIST") <(echo "$ENG_MSGID_LIST"))

        if [ ! -z "$COMPARE_MISSING" ]; then
            echo "$lang/LC_MESSAGES/$domain.po is missing msgid's present in en_US/LC_MESSAGES/$domain.po :"
            echo "$COMPARE_MISSING"
            echo "Please fix before continuing."
            exit 1
        fi

        if [ ! -z "$COMPARE_EXTRA" ]; then
            echo "$lang/LC_MESSAGES/$domain.po has extra msgid's compared to en_US/LC_MESSAGES/$domain.po :"
            echo "$COMPARE_EXTRA"
            echo "Please fix before continuing."
            exit 1
        fi

        # Number of lines differs?
        # Disabled for now

        # ENG_LINE_COUNT=$(wc -l < en_US/LC_MESSAGES/$domain.po)
        # NEW_LINE_COUNT=$(wc -l < $lang/LC_MESSAGES/$domain.po)

        # if [ "$ENG_LINE_COUNT" -ne "$NEW_LINE_COUNT" ]; then
        #     echo "Line count for $lang/LC_MESSAGES/$domain.po different from en_US/LC_MESSAGES/$domain.po"
        #     echo "Check for missing/extra newlines inside and at the top/bottom of the file"
        #     echo "en_US: $ENG_LINE_COUNT"
        #     echo "$lang: $NEW_LINE_COUNT"
        #     exit 1;
        # fi;

        # Untranslated strings?

        SKIP_DIFF_REGEX="en_(AU|GB|US)"

        if [[ $lang =~ $SKIP_DIFF_REGEX ]]; then
            echo "Skipping comparison for $domain.po: $lang is an English variant"
            continue
        fi

        RESULTS=$(diff --unchanged-line-format='%L' --old-line-format='' --new-line-format='' en_US/LC_MESSAGES/$domain.po $lang/LC_MESSAGES/$domain.po | sed '/^$/d' | grep -B1 msgstr | grep -Po "^msgid..\K.+?(?=\")" | sort)

        # check ignore list
        if [ -f $DIR/ignores/$lang/$domain.txt ]; then
            PRUNE=$(comm -23 <(echo "$RESULTS") <(sort $DIR/ignores/$lang/$domain.txt | uniq))
            RESULTS=$PRUNE
        fi

        if [ ! -z "$RESULTS" ]; then
            echo "$lang/LC_MESSAGES/$domain.po:"
            echo "$RESULTS"
            echo
        fi
    done
done

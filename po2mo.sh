#!/bin/bash

# Remove Gettext .mo files and regenerate them from the .po files
compiled_count=0

if [ "$#" -gt 0 ]; then
        po_files=""
        missing_domains=0

        for textdomain in "$@"; do
                matches=$(find . -name "${textdomain}.po" | grep -v "/old/")

                if [ -z "$matches" ]; then
                        echo "No .po files found for textdomain: $textdomain"
                        missing_domains=$((missing_domains + 1))
                        continue
                fi

                po_files="${po_files}${matches}"$'\n'
        done

        po_files=$(printf "%s" "$po_files" | sed '/^$/d')

        if [ -z "$po_files" ]; then
                echo "No .po files found for any requested textdomain."
                exit 1
        fi
else
        po_files=$(find . -name '*.po' | grep -v "/old/")
fi

while IFS= read -r po_file; do
        [ -z "$po_file" ] && continue

        base="${po_file%.po}"
        if [ -f "$base.mo" ]; then
                rm "$base.mo"
        fi

        msgfmt "$po_file" -o "$base.mo"
        echo "$base"
        compiled_count=$((compiled_count + 1))
done <<< "$po_files"

if [ "$#" -gt 0 ]; then
        echo "Done! Recompiled $compiled_count textdomain file(s) for: $*."
else
        echo "Done! Recompiled $compiled_count textdomain file(s)."
fi

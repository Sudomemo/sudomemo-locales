#!/bin/bash

# Remove Gettext .mo files and regenerate them from the .po files
textdomain="$1"
compiled_count=0

if [ -n "$textdomain" ]; then
	po_files=$(find . -name "${textdomain}.po")
	if [ -z "$po_files" ]; then
		echo "No .po files found for textdomain: $textdomain"
		exit 1
	fi
else
	po_files=$(find . -name '*.po')
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

if [ -n "$textdomain" ]; then
	echo "Done! Recompiled $compiled_count textdomain file(s) for '$textdomain'."
else
	echo "Done! Recompiled $compiled_count textdomain file(s)."
fi

echo "Make sure to update file permissions and reload Apache."

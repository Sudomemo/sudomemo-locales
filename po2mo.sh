#!/bin/bash
for i in $(find . -name \*.po|sed 's/\.po//g'); do
	if [ -f "$i.mo" ]; then
		rm $i.mo;
		msgfmt $i.po -o $i.mo
		echo $i;
	fi
done

chown -R apache. *
echo "Done!"

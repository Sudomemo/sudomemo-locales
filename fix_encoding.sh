#!/bin/bash

# fix issues where we have ISO-8859-1 encoded files..

find|grep "\.po"|xargs file|grep ISO|awk -F: '{print $1}' | xargs -L1 -I{} iconv -f ISO-8859-1 -t UTF-8//TRANSLIT {} -o {}

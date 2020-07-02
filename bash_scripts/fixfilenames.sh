#!/bin/bash

if [[ "$#" != "1" ]]; then
    echo "Usage: $0 [file specifier]"
fi

files=$1

# removes all "Umlaute" an spaces in filenames

rename -n 's/\ /\_/g;s/ö/oe/g;s/ä/ae/g;s/ü/ue/g;s/Ö/Oe/g;s/Ä/Ae/g;s/Ü/Ue/g' $files

read -n 1 -p "Proceed[y/n]? " answer
echo ""

if [[ "$answer" == "y" ]]; then
    rename 's/\ /\_/g;s/ö/oe/g;s/ä/ae/g;s/ü/ue/g;s/Ö/Oe/g;s/Ä/Ae/g;s/Ü/Ue/g' $files
fi

exit $?

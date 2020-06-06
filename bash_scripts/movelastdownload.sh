#!/bin/bash

ERRUSE="Usage: $0 TARGET-DIRECTORY"
ERRDIR="TARGET-DIRECTORY not found"

TARGET=$1

if [[ "$#" != "1" ]]; then
    echo $ERRUSE
    exit 1
elif [[ ! -d $TARGET ]]; then
    echo $ERRDIR
    exit 2
else
    LAST_DOWNLOAD=`ls -t ~/Downloads | head -n 1`
    mv ~/Downloads/$LAST_DOWNLOAD $TARGET
    exit $?
fi

#!/bin/bash

ERRUSE="Usage: $0 TARGET-DIRECTORY [NUMBER-OF-FILES]"
ERRDIR="TARGET-DIRECTORY not found"

TARGET=$1
NUM=${2:-1}

if (( $# < 1 )); then
    echo $ERRUSE
    exit 1
elif [[ ! -d $TARGET ]]; then
    echo $ERRDIR
    exit 2
else
    LAST_DOWNLOAD=`ls -t ~/Downloads | head -n $NUM`
    for f in $LAST_DOWNLOAD; do
        mv ~/Downloads/$f $TARGET
    done
    exit $?
fi

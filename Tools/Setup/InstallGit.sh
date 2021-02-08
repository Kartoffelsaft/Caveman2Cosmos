#!/bin/sh

GIT_DIR=`command -v git`

if [ -n "$GIT_DIR" ]
then
    echo 'Git needs to be installed' > /dev/stderr
    exit 1
fi

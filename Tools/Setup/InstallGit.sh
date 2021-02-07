#!/bin/sh

GIT_DIR=`command -v git`

if [ -n "$GIT_DIR" ]
then
else
    echo 'Git needs to be installed' > /dev/stderr
    return 1
fi

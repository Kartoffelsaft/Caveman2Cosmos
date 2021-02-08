#!/bin/sh

### Init ###

cmdInvoke=1

### Install ###

cd ./Tools
    cd ./Setup
        ./InstallGit.sh
    cd ..
    ./Install.sh
    ./_MakeDLL.sh release build
    ./_MakeDLL.sh release deploy
cd ..

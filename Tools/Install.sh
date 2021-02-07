#!/bin/sh

if ! [ $1 = "DevSetup" ]
then
    echo '
This script will link from your Git workspace directly into your Mods folder.
It is designed so you can have your Git workspace OUTSIDE of the BtS Mods folder
but still run the Mod without having to export or copy. It does this by making links
from specific directories in the Git workspace directly into the Mods directory.
Once this script is run you do NOT need to run it again unless you do a clean
fetch from Git or otherwise delete/move the folders in the workspace.
-- [Author @billw on discord / @billw2015 on the forums]

This script will:
  1. (optional) Give you a directory browser to select your Mods location.
  2. Create the Caveman2Cosmos directory under Mods.
  3. Create the appropriate links from your Git workspace to that new directory.
  4. Copy any files that should not be linked to that new directory.

After it is complete you should be able to run the Mod without issue.

IMPORTANT:
    Running this script is only appropriate if your Git workspace (from which you are 
    running now) is OUTSIDE the Mods directory. If you want to have Git in the Mods 
    directory then this script isnt for you.
NOTE:
    If you previously used this script then it should have saved the Mods directory
    from last time. If you want to reset the saved directory then delete
    Tools\mods_directory.txt
'
fi

if [ -f '../../../Civ4BeyondSword.exe' ]
then
    echo '
It looks like you are running this script from within the BtS Mods directory.
As explained in the README above, it is intended to install TO the Mods directory FROM
somewhere else!
If you want to use it then move your Git workspace out of the Mods directory
to somewhere else, then run this script again from there instead.
' > /dev/stderr
    return 1
fi

if [ -f 'mods_directory.txt' ]
then
    echo 'using previous saved mod directory (in mods_directory.txt)'
    MOD_DIRECTORY=`cat mods_directory`
else
    useGraphicalFilePrompt=true

    if useGraphicalFilePrompt
    then
        if [ -n `command -v zenity` ]
        then
            MOD_DIRECTORY=`zenity --file-selection --directory`
        else
            echo '
This script is set to use a graphical prompt but none was found.
you can install zenity, or alternatively enter the mods directory here (preferably absolute):'
            read MOD_DIRECTORY
        fi
    else
        read -p 'Please specify your mods directory (preferably absolute):' MOD_DIRECTORY
    fi

    if ! [ -n "${MOD_DIRECTORY}/../Civ4BeyondSword.exe" ]
    then
        echo 'The mod directory specified does not appear to be correct'
        exit 1
    fi

    echo $MOD_DIRECTORY > mods_directory.txt
fi

if [ -d "${MOD_DIRECTORY}/Caveman2Cosmos" ]
then
    if ! [ -L "${MOD_DIRECTORY}/Caveman2Cosmos" ]
    then
        mv ${MOD_DIRECTORY}/Caveman2Cosmos ${MOD_DIRECTORY}/Caveman2CosmosBackup
    fi
fi


C2C_DIRECTORY=`pwd | sed 's/^\(.*Caveman2Cosmos\).*$/\1/g'`

if ! [ -d "${MOD_DIRECTORY}/Caveman2Cosmos" ]
then
    ln -s ${C2C_DIRECTORY} ${MOD_DIRECTORY}/Caveman2Cosmos
fi

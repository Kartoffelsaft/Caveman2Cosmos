#!/bin/sh

if ! [ -d '../Build/deps' ]
then
    echo 'Getting Dependencies...'
    mkdir -p ../Build/deps

    if ! [ -e '/tmp/boost1_55_0.7z' ]
    then
        wget 'https://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.7z?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.55.0%2Fboost_1_55_0.7z%2Fdownload&ts=1612657890' -O /tmp/boost1_55_0.7z
    fi
    7z x '/tmp/boost1_55_0.7z' -o/tmp/boost1_55_0
    mv '/tmp/boost1_55_0/boost_1_55_0' '../Build/deps/Boost-1.55.0'
    ln -sr '../Build/deps/Boost-1.55.0' '../Build/deps/Boost-1.55.0/include'
    ln -sr '../Build/deps/Boost-1.55.0/boost' '../Build/deps/Boost-1.55.0/boost155'

    if ! [ -e '/tmp/boost1_32_0.zip' ]
    then
        wget 'https://downloads.sourceforge.net/project/boost/boost/1.32.0/boost_1_32_0.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.32.0%2Fboost_1_32_0.zip%2Fdownload&ts=1612662497' -O /tmp/boost1_32_0.zip
    fi
    7z x '/tmp/boost1_32_0.zip' -o/tmp/boost1_32_0
    mv '/tmp/boost1_32_0/boost_1_32_0' '../Build/deps/Boost-1.32.0'
    ln -sr '../Build/deps/Boost-1.32.0' '../Build/deps/Boost-1.32.0/include'

    if ! [ -e '/tmp/python2_4.zip' ]
    then
        wget 'https://github.com/python/cpython/archive/v2.4.3.zip' -O /tmp/python2_4.zip
    fi
    7z x '/tmp/python2_4.zip' -o/tmp/python2_4
    mv '/tmp/python2_4/cpython-2.4.3' '../Build/deps/Python24'
    cp '../Build/deps/Python24/PC/pyconfig.h' '../Build/deps/Python24/Include'
fi

if ! [ -d '../Build/include' ]
then
    mkdir -p ../Build/include
    ln -s '/usr/i686-w64-mingw32/include/mmsystem.h' '../Build/include/MMSystem.h'
    ln -s '/usr/i686-w64-mingw32/include/windows.h' '../Build/include/Windows.h'
fi

TARGET="${1}-build"
BUILD_DIR="`pwd`/../build"
TARGET_DIR="${BUILD_DIR}/${1}"
DLL_PATH="${TARGET_DIR}/CvGameCoreDLL.dll"
PDB_PATH="${TARGET_DIR}/CvGameCoreDLL.pdb"
# I Don't know what the FDB file is for, but it's in the original file
# Presumably something that fbuild uses?
FDB_PATH="${TARGET_DIR}/CvGameCoreDLL.fdb"
DEPLOY_DIR="`pwd`/../Assets"
COMPILER='i686-w64-mingw32-g++'
COMPILER_ARGS=(
    '-s'
    '-shared'
    '-Wl,--subsystem,windows'
    '-lwinmm'
    '-std=c++11'
)
DEPENDENCIES=(
    '-I../Build/deps/Boost-1.55.0/include'
    '-I../Build/deps/Boost-1.32.0/include'
    '-I../Build/deps/Python24/Include'
    '-I../Sources/include'
    '-I../Build/include'
)
SOURCES=`find ../Sources | rg '\.c(pp)?'`

if [ "${2}" = "build" ]
then
    $COMPILER -o $DLL_PATH ${SOURCES[*]} ${COMPILER_ARGS[*]} ${DEPENDENCIES[*]}
elif [ "${2}" = "deploy" ]
then
    # the PDB and FDB are unused for now
    cp -t $DEPLOY_DIR $DLL_PATH # $PDB_PATH $FDB_PATH
else
    echo "WARNING: ${2} is unimplemented"
fi

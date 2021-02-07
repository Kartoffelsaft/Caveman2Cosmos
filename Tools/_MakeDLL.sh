if ! [ -d '../Build/deps' ]
then
    echo 'Getting Dependencies...'
    mkdir -p ../Build/deps

    wget 'https://downloads.sourceforge.net/project/boost/boost/1.55.0/boost_1_55_0.7z?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.55.0%2Fboost_1_55_0.7z%2Fdownload&ts=1612657890' -O /tmp/boost1_55_0.7z
    7z x -o/tmp/boost1_55_0
    mv /tmp/boost1_55_0/boost_1_55_0 '../Build/deps/Boost-1.55.0'
    ln -s '../Build/deps/Boost-1.55.0/boost' '../Build/deps/Boost-1.55.0/include'

    wget 'https://downloads.sourceforge.net/project/boost/boost/1.32.0/boost_1_32_0.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.32.0%2Fboost_1_32_0.zip%2Fdownload&ts=1612662497' -O /tmp/boost1_32_0.7z
    7z x -o/tmp/boost1_32_0
    mv /tmp/boost1_32_0/boost_1_32_0 '../Build/deps/Boost-1.32.0'
    ln -s '../Build/deps/Boost-1.32.0/boost' '../Build/deps/Boost-1.32.0/include'
fi

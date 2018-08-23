#!/bin/bash
VERSION=${VERSION:-"master"}
SRC_DIR=${SRC_DIR:-$HOME/sources}
INSTALL_PREFIX=${INSTALL_PREFIX:-$HOME/.local/}
EXTRA_OPTIONS=${EXTRA_OPTIONS:-""}
WITH_EXTRA=${WITH_EXTRA:-false}
WITH_SUDO=${WITH_SUDO:-false}

echo "opencv version to be installed: $VERSION"
echo "source code directory: $SRC_DIR"
echo "extra cmake options: $EXTRA_OPTIONS"

if [ ! -d $SRC_DIR ]; then
    mkdir -p $SRC_DIR
fi
cd $SRC_DIR

deps=(ffmpeg libx264-dev libjpeg-dev libpng-dev libtiff-dev libavcodec-dev \
libavformat-dev libv4l-dev libswscale-dev libgtk-3-dev libtbb2 libtbb-dev)

missing=()
for lib in ${deps[@]}; do
    dpkg -l $lib | grep -w $lib &> /dev/null || missing+=($lib)
done

if [ ${#missing[@]} -gt 0 ]; then
    if [ $WITH_SUDO = false ]; then
        echo -e "\033[31mWARNING:\033[0m package(s) '"${missing[@]}\' was not installed.
        exit -1
    else
        sudo apt install -y "${missing[@]}"
    fi
fi

pip3 install numpy --user --upgrade
pip install numpy --user --upgrade

if [ ! -d "opencv" ]; then
    git clone https://github.com/opencv/opencv.git
else
    cd opencv
    cur_branch=$(git name-rev --name-only HEAD)
    if [ $cur_branch != $VERSION ]; then
        if [ $VERSION = "master" ]; then
            git checkout master
        else
            git fetch origin
            git checkout tags/$VERSION -b $VERSION
        fi
    fi
    git pull
    cd ..
fi
if [ $WITH_EXTRA = true ]; then
    if [ ! -d "opencv_contrib" ]; then
        git clone https://github.com/opencv/opencv_contrib.git
    else
        cd opencv_contrib
        cur_branch=$(git name-rev --name-only HEAD)
        if [ $cur_branch != $VERSION ]; then
            if [ $VERSION = "master" ]; then
                git checkout master
            else
                git fetch origin
                git checkout tags/$VERSION -b $VERSION
            fi
        fi
        git pull
        cd ..
    fi
fi

cd opencv
if [ -d "build" ]; then
    rm -rf build
fi
if [ $WITH_EXTRA = true ]; then
    EXTRA_OPTIONS="-DOPENCV_EXTRA_MODULES_PATH=$SRC_DIR/opencv_contrib/modules
                   -DBUILD_opencv_cnn_3dobj=OFF
                   -DBUILD_opencv_dnn=OFF
                   -DBUILD_opencv_dnn_modern=OFF
                   -DBUILD_opencv_dnns_easily_fooled=OFF"
fi
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
      -DWITH_TBB=ON -DWITH_OPENCL=OFF $EXTRA_OPTIONS ..

make -j
make install

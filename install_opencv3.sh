SRC_DIR=${SRC_DIR:-$HOME/sources}
INSTALL_PREFIX=${INSTALL_PREFIX:-$HOME/.local/}
WITH_SUDO=${WITH_SUDO:-false}

if [ -d $SRC_DIR ]; then
    mkdir -p $SRC_DIR
fi

deps=(ffmpeg libjpeg-dev libpng-dev libtiff-dev libjasper-dev libavcodec-dev \
libavformat-dev libv4l-dev libswscale-dev libavutil-dev libgtk2.0-dev libtbb2 libtbb-dev)

missing=()
for lib in ${deps[@]}; do
    dpkg -l $lib | grep -w $lib &> /dev/null || missing+=($lib)
done

if [ ${#missing[@]} -gt 0 ]; then
    if [ "$WITH_SUDO" = false ]; then
        echo -e "\033[31mWARNING:\033[0m package(s) '"${missing[@]}\' was not installed.
    else
        sudo apt install -y "${missing[@]}"
    fi
fi

git clone git@github.com:opencv/opencv.git
git clone git@github.com:opencv/opencv_contrib.git
cd opencv
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
-DWITH_TBB=ON \
-DOPENCV_EXTRA_MODULES_PATH=$SRC_DIR/opencv_contrib/modules \
-DBUILD_opencv_cnn_3dobj=OFF \
-DBUILD_opencv_dnn=OFF \
-DBUILD_opencv_dnn_modern=OFF \
-DBUILD_opencv_dnns_easily_fooled=OFF \
..

make -j
make install
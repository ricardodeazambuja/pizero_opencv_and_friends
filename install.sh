#!/bin/bash

OPENCV_VERSION="4.1.0"

sudo apt-get update && \
sudo apt-get install -y --fix-missing --no-install-recommends \
wget \
unzip \
build-essential \
cmake \
pkg-config \
python3 \
python3-dev \
python3-pip \
python3-setuptools \
python3-wheel \
python3-numpy \
libjpeg-dev \
libpng-dev \
libtiff5-dev \
libtiff-dev \
libxine2-dev \
libv4l-dev \
libavcodec-dev \
libavformat-dev \
libswscale-dev \
libxvidcore-dev \
libx264-dev \
libavresample-dev \
libjasper-dev \
libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev \
libtbb-dev \
libhdf5-dev \
v4l-utils \
ffmpeg \
libeigen3-dev \
gfortran \
libatlas-base-dev \
liblapack-dev \
libblas-dev \
liblapacke-dev \
libprotobuf-dev \
protobuf-compiler \
libgoogle-glog-dev \
libgflags-dev \
libfreetype6-dev \
python3-picamera && \
sudo apt-get clean && sudo rm -rf /tmp/* /var/tmp/* && \
cd /usr/include/linux && sudo ln -s -f ../libv4l1-videodev.h videodev.h && \
cd /opt && \
sudo wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
sudo unzip ${OPENCV_VERSION}.zip && \
sudo rm -rf ${OPENCV_VERSION}.zip && \
# opencv_contrib
cd /opt && \
sudo wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
sudo unzip ${OPENCV_VERSION}.zip && \
sudo rm -rf ${OPENCV_VERSION}.zip && \
sudo mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
cd /opt/opencv-${OPENCV_VERSION}/build && \
sudo cmake \
-D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_FFMPEG=ON \
-D WITH_OPENGLES=ON `# RPI ZERO doesn't has full OPENGL, but OPENGLES.`\
-D ENABLE_NEON=NO `# RPI ZERO doesn't has NEON or VFPV3`\
-D ENABLE_VFPV3=NO `# RPI ZERO doesn't has NEON or VFPV3`\
-D OPENCV_ENABLE_NONFREE=ON \
-D WITH_QT=OFF \
-D WITH_GTK=OFF \
-D WITH_CUDA=OFF \
-D BUILD_opencv_java=OFF \
-D BUILD_JAVA=NO \
-D BUILD_EXAMPLES=NO \
-D BUILD_ANDROID_EXAMPLES=NO \
-D INSTALL_PYTHON_EXAMPLES=NO \
-D BUILD_DOCS=NO \
-D BUILD_opencv_python2=NO \
-D BUILD_opencv_python3=ON \
.. && \
# make VERBOSE=1 && \
# -j6 will work because I'm compiling on my laptop instead of the rpi zero ;)
# on the rpi zero, you will have only one core so -j is useless...
sudo make -j6 && \
sudo make install && \
sudo ldconfig && \
cd / && \
sudo rm -rf /opt/opencv-${OPENCV_VERSION} && \
sudo pip3 --no-cache-dir install dlib && \
sudo pip3 --no-cache-dir install scikit-image && \
sudo pip3 --no-cache-dir install cython && \
sudo pip3 --no-cache-dir install scikit-learn && \
sudo pip3 --no-cache-dir install scikit-video && \
sudo rm -rf /tmp/* /var/tmp/*

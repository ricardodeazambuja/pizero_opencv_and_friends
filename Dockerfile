FROM balenalib/rpi-raspbian:stretch

ENV OPENCV_VERSION=4.1.0 

RUN apt-get update && \
    apt-get install -y --fix-missing --no-install-recommends \
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
    apt-get clean && rm -rf /tmp/* /var/tmp/* && \
    cd /usr/include/linux && ln -s -f ../libv4l1-videodev.h videodev.h && \
    cd /opt && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    rm -rf ${OPENCV_VERSION}.zip && \
    # opencv_contrib
    cd /opt && \
    wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    rm -rf ${OPENCV_VERSION}.zip && \
    mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
    cd /opt/opencv-${OPENCV_VERSION}/build && \
    cmake \
    -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_FFMPEG=ON \
    -D WITH_OPENGLES=ON \
    # RPI ZERO doesn't has full OPENGL, but OPENGLES.
    -D ENABLE_NEON=NO \
    -D ENABLE_VFPV3=NO \  
    # RPI ZERO doesn't has NEON or VFPV3
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
    make -j6 && \
    make install && \
    ldconfig && \
    cd / && \
    rm -rf /opt/opencv-${OPENCV_VERSION} && \
    pip3 --no-cache-dir install dlib && \
    pip3 --no-cache-dir install scikit-image && \
    pip3 --no-cache-dir install scikit-learn && \
    pip3 --no-cache-dir install scikit-video && \
    rm -rf /tmp/* /var/tmp/*

# -- General configuration for OpenCV 4.1.0 =====================================
# --   Version control:               unknown
# -- 
# --   Extra modules:
# --     Location (extra):            /opt/opencv_contrib-4.1.0/modules
# --     Version control (extra):     unknown
# -- 
# --   Platform:
# --     Timestamp:                   2019-06-20T14:15:21Z
# --     Host:                        Linux 4.18.0-21-generic armv6l
# --     CMake:                       3.7.2
# --     CMake generator:             Unix Makefiles
# --     CMake build tool:            /usr/bin/make
# --     Configuration:               RELEASE
# -- 
# --   CPU/HW features:
# --     Baseline:
# --       requested:                 DETECT
# --       disabled:                  VFPV3 NEON
# -- 
# --   C/C++:
# --     Built as dynamic libs?:      YES
# --     C++ Compiler:                /usr/bin/c++  (ver 6.3.0)
# --     C++ flags (Release):         -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wno-delete-non-virtual-dtor -Wno-comment -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -mfp16-format=ieee -fvisibility=hidden -fvisibility-inlines-hidden -O3 -DNDEBUG  -DNDEBUG
# --     C++ flags (Debug):           -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wundef -Winit-self -Wpointer-arith -Wshadow -Wsign-promo -Wuninitialized -Winit-self -Wno-delete-non-virtual-dtor -Wno-comment -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -mfp16-format=ieee -fvisibility=hidden -fvisibility-inlines-hidden -g  -O0 -DDEBUG -D_DEBUG
# --     C Compiler:                  /usr/bin/cc
# --     C flags (Release):           -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-comment -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -mfp16-format=ieee -fvisibility=hidden -O3 -DNDEBUG  -DNDEBUG
# --     C flags (Debug):             -fsigned-char -W -Wall -Werror=return-type -Werror=non-virtual-dtor -Werror=address -Werror=sequence-point -Wformat -Werror=format-security -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wundef -Winit-self -Wpointer-arith -Wshadow -Wuninitialized -Winit-self -Wno-comment -fdiagnostics-show-option -pthread -fomit-frame-pointer -ffunction-sections -fdata-sections  -mfp16-format=ieee -fvisibility=hidden -g  -O0 -DDEBUG -D_DEBUG
# --     Linker flags (Release):      -Wl,--gc-sections  
# --     Linker flags (Debug):        -Wl,--gc-sections  
# --     ccache:                      NO
# --     Precompiled headers:         YES
# --     Extra dependencies:          dl m pthread rt
# --     3rdparty dependencies:
# -- 
# --   OpenCV modules:
# --     To be built:                 aruco bgsegm bioinspired calib3d ccalib core datasets dnn dnn_objdetect dpm face features2d flann fuzzy gapi hdf hfs highgui img_hash imgcodecs imgproc line_descriptor ml objdetect optflow phase_unwrapping photo plot python3 quality reg rgbd saliency sfm shape stereo stitching structured_light superres surface_matching text tracking ts video videoio videostab xfeatures2d ximgproc xobjdetect xphoto
# --     Disabled:                    world
# --     Disabled by dependency:      -
# --     Unavailable:                 cnn_3dobj cudaarithm cudabgsegm cudacodec cudafeatures2d cudafilters cudaimgproc cudalegacy cudaobjdetect cudaoptflow cudastereo cudawarping cudev cvv freetype java js matlab ovis python2 viz
# --     Applications:                tests perf_tests apps
# --     Documentation:               NO
# --     Non-free algorithms:         YES
# -- 
# --   GUI: 
# --     VTK support:                 NO
# -- 
# --   Media I/O: 
# --     ZLib:                        /usr/lib/arm-linux-gnueabihf/libz.so (ver 1.2.8)
# --     JPEG:                        /usr/lib/arm-linux-gnueabihf/libjpeg.so (ver 62)
# --     WEBP:                        build (ver encoder: 0x020e)
# --     PNG:                         /usr/lib/arm-linux-gnueabihf/libpng.so (ver 1.6.28)
# --     TIFF:                        /usr/lib/arm-linux-gnueabihf/libtiff.so (ver 42 / 4.0.8)
# --     JPEG 2000:                   /usr/lib/arm-linux-gnueabihf/libjasper.so (ver 1.900.1)
# --     OpenEXR:                     build (ver 1.7.1)
# --     HDR:                         YES
# --     SUNRASTER:                   YES
# --     PXM:                         YES
# --     PFM:                         YES
# -- 
# --   Video I/O:
# --     DC1394:                      NO
# --     FFMPEG:                      YES
# --       avcodec:                   YES (57.64.101)
# --       avformat:                  YES (57.56.101)
# --       avutil:                    YES (55.34.101)
# --       swscale:                   YES (4.2.100)
# --       avresample:                YES (3.1.0)
# --     GStreamer:                   YES (1.10.4)
# --     v4l/v4l2:                    YES (linux/videodev2.h)
# -- 
# --   Parallel framework:            pthreads
# -- 
# --   Trace:                         YES (built-in)
# -- 
# --   Other third-party libraries:
# --     Lapack:                      YES (/usr/lib/liblapack.so /usr/lib/libcblas.so /usr/lib/libatlas.so)
# --     Eigen:                       YES (ver 3.3.2)
# --     Custom HAL:                  YES (carotene (ver 0.0.1))
# --     Protobuf:                    build (3.5.1)
# -- 
# --   OpenCL:                        YES (no extra features)
# --     Include path:                /opt/opencv-4.1.0/3rdparty/include/opencl/1.2
# --     Link libraries:              Dynamic load
# -- 
# --   Python 3:
# --     Interpreter:                 /usr/bin/python3 (ver 3.5.3)
# --     Libraries:                   /usr/lib/arm-linux-gnueabihf/libpython3.5m.so (ver 3.5.3)
# --     numpy:                       /usr/lib/python3/dist-packages/numpy/core/include (ver 1.12.1)
# --     install path:                lib/python3.5/dist-packages/cv2/python-3.5
# -- 
# --   Python (for build):            /usr/bin/python3
# -- 
# --   Install to:                    /usr/local
# -- -----------------------------------------------------------------
# -- 
# -- Configuring done
# -- Generating done
# -- Build files have been written to: /opt/opencv-4.1.0/build

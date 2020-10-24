#!/bin/bash
set -x
# CREDIT # https://github.com/BVLC/caffe/wiki/OpenCV-3.3-Installation-Guide-on-Ubuntu-16.04

sudo apt update
sudo apt upgrade
sudo apt autoremove

sudo apt-get install --assume-yes build-essential cmake git
sudo apt-get install --assume-yes pkg-config unzip ffmpeg qtbase5-dev python-dev python3-dev python-numpy python3-numpy
sudo apt-get install --assume-yes libopencv-dev libgtk-3-dev libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev
sudo apt-get install --assume-yes libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt-get install --assume-yes libv4l-dev libtbb-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev
sudo apt-get install --assume-yes libvorbis-dev libxvidcore-dev v4l-utils vtk6
sudo apt-get install --assume-yes liblapacke-dev libopenblas-dev libgdal-dev checkinstall

sudo apt-get install --assume-yes libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

sudo apt-get install --assume-yes clang libc++-dev libc++abi-dev
sudo update-alternatives --config c++

echo "Do you wish to install opencv-3.4.1 (type a number 1 or 2)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
		unzip opencv-3.4.1.zip
		cd opencv-3.4.1

		mkdir build
		cd build/    
		cmake -D CMAKE_CXX_FLAGS=-isystem\ /usr/include/libcxxabi -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D FORCE_VTK=ON -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUBLAS=ON -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" -D WITH_GDAL=ON -D WITH_XINE=ON -D BUILD_EXAMPLES=ON ..
		make -j $(($(nproc) + 1))

		sudo make install
		sudo /bin/bash -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
		sudo ldconfig

             	break;;

        No ) 	break;;
    esac
done

echo "Do you wish to remove default opencv-2.4 (type a number 1 or 2)?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
		sudo apt purge libopencv*
		sudo apt purge opencv*

             	break;;

        No ) 	break;;
    esac
done

sudo apt update
sudo apt upgrade
sudo apt autoremove
sudo ldconfig


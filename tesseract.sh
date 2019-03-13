#!/bin/bash

# You can skip this part if you are using CentOs. This part is required for RHEL versions.
cd /tmp
sudo wget http://mirrors.nju.edu.cn/gnu/autoconf-archive/autoconf-archive-2019.01.06.tar.xz
sudo tar xf autoconf-archive-2019.01.06.tar.xz 
cd autoconf-archive-2019.01.06
sudo ./configure && make && make install
sudo cp ./m4/* /usr/share/aclocal/

# People using CentOs can start from here
cd /opt
sudo yum -y update
sudo yum -y install libstdc++ autoconf automake libtool autoconf-archive pkg-config gcc gcc-c++ make libjpeg-devel libpng-devel libtiff-devel zlib-devel
sudo yum group install -y "Development Tools"

sudo wget http://www.leptonica.com/source/leptonica-1.75.3.tar.gz
sudo tar -zxvf leptonica-1.75.3.tar.gz
cd leptonica-1.75.3
sudo ./autobuild
sudo ./configure
sudo make -j
sudo make install
cd ..

sudo wget https://github.com/tesseract-ocr/tesseract/archive/4.0.0-beta.1.tar.gz
sudo tar -zxvf 4.0.0-beta.1.tar.gz
cd tesseract-4.0.0-beta.1/
sudo ./autogen.sh
sudo PKG_CONFIG_PATH=/usr/local/lib/pkgconfig LIBLEPT_HEADERSDIR=/usr/local/include ./configure --with-extra-includes=/usr/local/include --with-extra-libraries=/usr/local/lib
sudo LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make -j
sudo make install
sudo ldconfig
cd ..

sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata
sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/equ.traineddata
sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/chi_sim.traineddata
# download another other languages you like
sudo mv *.traineddata /usr/local/share/tessdata

sudo pip-3.4 install pytesseract


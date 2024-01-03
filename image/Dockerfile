FROM ubuntu:20.04 as base

FROM base as builder

RUN echo "deb http://dk.archive.ubuntu.com/ubuntu/ xenial main" >> /etc/apt/sources.list
RUN echo "deb http://dk.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Asia/Taipei apt-get install -y \
    wget \
    vim \
    git \
    cmake \
    build-essential \
    libgl1-mesa-dev \
    libfftw3-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libgeographic-dev \
    zlib1g-dev \
    m4 \
    software-properties-common \
    pkg-config \
    g++-4.7

RUN add-apt-repository ppa:rock-core/qt4 && apt-get install -y qt4-default

RUN wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_14_3/src/hdf5-1.14.3.tar.gz && \
    tar -zxvf hdf5-1.14.3.tar.gz
RUN cd hdf5-1.14.3 && \
    ./configure --enable-shared --enable-hl --prefix=/usr/local && \
    make -j 24 && \
    make install

RUN wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.9.2.tar.gz && \
    tar -zxvf v4.9.2.tar.gz
RUN cd netcdf-c-4.9.2 && \
    ./configure --enable-shared --prefix=/usr/local && \
    make -j 24 && \
    make install

RUN wget https://downloads.unidata.ucar.edu/netcdf-cxx/4.2/netcdf-cxx-4.2.tar.gz && \
    tar -zxvf netcdf-cxx-4.2.tar.gz
RUN cd netcdf-cxx-4.2 && \
    ./configure --enable-shared --prefix=/usr/local && \
    make -j 24 && \
    make install

RUN wget https://sourceforge.net/projects/geographiclib/files/distrib/archive/GeographicLib-1.35.tar.gz && \
    tar -zxvf GeographicLib-1.35.tar.gz
RUN cd GeographicLib-1.35 && \
    mkdir build && \
    cd build && \
    ../configure && \
    make -j 24 && \
    make install

RUN wget https://www.zlib.net/zlib-1.3.tar.gz && \
    tar -zxvf zlib-1.3.tar.gz
RUN cd zlib-1.3 && \
    ./configure --prefix=/usr/local && \
    make -j 24 && \
    make install

RUN git clone -b thermoretrieval https://github.com/mmbell/samurai.git
RUN sed -i 's/g++-4.2/g++-4.7/' /samurai/CMakeLists.txt

COPY src /samurai/src

WORKDIR /samurai

RUN cmake . && make && make install
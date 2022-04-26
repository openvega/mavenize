#!/bin/bash

export MAJOR_VER=1
export MINOR_VER=76
export BUILD=3
export SRC=/c/Boost
export SRC_INC=${SRC}/include/boost-${MAJOR_VER}_${MINOR_VER}
export SRC_NAME=-vc142-mt-x64-${MAJOR_VER}_${MINOR_VER}
export DEBUG_SRC_NAME=-vc142-mt-gd-x64-${MAJOR_VER}_${MINOR_VER}
export VERSION=${MAJOR_VER}.${MINOR_VER}.${BUILD}
export PYVERSION=${MAJOR_VER}.${MINOR_VER}.0
export AOL_WIN=amd64-Windows-msvc
export AOL_LINUX=amd64-Linux-gpp
export SRC_LIB=${SRC}/lib
export SRC_LINUX_LIB=${SRC}/linuxlib
export PYVER=36

if [ -d boost/src/nar/resources/noarch/include/boost ]; then
    rm -rf boost/src/nar/resources/noarch/include/boost
fi
mkdir -p boost/src/nar/resources/noarch/include
cp -Rp ${SRC_INC}/boost boost/src/nar/resources/noarch/include/

for p in boost_log_setup boost_log boost_chrono boost_date_time  boost_program_options boost_regex boost_filesystem boost_thread boost_system 
do
    echo "Preparing ${p} ..."
    if [ -d ${p}/src/nar/resources/aol/${AOL_WIN}/lib ]; then
        rm ${p}/src/nar/resources/aol/${AOL_WIN}/lib/*
    fi
    mkdir -p ${p}/src/nar/resources/aol/${AOL_WIN}/lib

    cp -p ${SRC_LIB}/lib${p}${SRC_NAME}.lib ${p}/src/nar/resources/aol/${AOL_WIN}/lib/${p}-${VERSION}.lib
    cp -p ${SRC_LIB}/lib${p}${DEBUG_SRC_NAME}.lib ${p}/src/nar/resources/aol/${AOL_WIN}/lib/${p}-${VERSION}d.lib

    if [ -d ${SRC_LINUX_LIB} ]; then
        if [ -d ${p}/src/nar/resources/aol/${AOL_LINUX}/lib ]; then
            rm ${p}/src/nar/resources/aol/${AOL_LINUX}/lib/*
        fi
        mkdir -p ${p}/src/nar/resources/aol/${AOL_LINUX}/lib 
        cp -p ${SRC_LINUX_LIB}/lib${p}.a ${p}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}-${VERSION}.a
    fi
done

p=boost_python
echo "Preparing ${p} ..."
if [ -d ${p}/src/nar/resources/aol/${AOL_WIN}/lib ]; then
    rm ${p}/src/nar/resources/aol/${AOL_WIN}/lib/*
fi
mkdir -p ${p}/src/nar/resources/aol/${AOL_WIN}/lib
cp -p ${SRC_LIB}/${p}${PYVER}${SRC_NAME}.lib ${p}/src/nar/resources/aol/${AOL_WIN}/lib/${p}-${VERSION}.lib
cp -p ${SRC_LIB}/${p}${PYVER}${SRC_NAME}.dll ${p}/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/${p}${PYVER}${DEBUG_SRC_NAME}.lib ${p}/src/nar/resources/aol/${AOL_WIN}/lib/${p}-${VERSION}d.lib
cp -p ${SRC_LIB}/${p}${PYVER}${DEBUG_SRC_NAME}.dll ${p}/src/nar/resources/aol/${AOL_WIN}/lib/

if [ -d ${SRC_LINUX_LIB} ]; then
    if [ -d ${p}/src/nar/resources/aol/${AOL_LINUX}/lib ]; then
        rm ${p}/src/nar/resources/aol/${AOL_LINUX}/lib/*
    fi
    mkdir -p ${p}/src/nar/resources/aol/${AOL_LINUX}/lib 
    cp -p ${SRC_LINUX_LIB}/lib${p}${PYVER}.so ${p}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}-${VERSION}.so
    cp -p ${SRC_LINUX_LIB}/lib${p}${PYVER}.so ${p}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}${PYVER}.so.${PYVERSION}
fi
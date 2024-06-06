#!/bin/bash

export VERSION=1.4.3.5
export SRC_VERSION=1.4.3
export SRC=/c/dev/thirdparty/fix8-${SRC_VERSION}
export SRC_LINUX=/c/dev/thirdparty/fix8-${SRC_VERSION}-inst
export POCO_LINUX=/c/dev/thirdparty/poco-1.13.3-inst
export SRC_INC=${SRC}/include/
export DEPEND_PKG=${SRC}/msvc/packages/fix8.deps.1.4.20191017.1/installed/x64-windows
export TBB_INC=${DEPEND_PKG}/include/tbb

export AOL_WIN=amd64-Windows-msvc
export AOL_LINUX=amd64-Linux-gpp
export SRC_LIB=${SRC}/msvc/x64/bin

# FIX8
if [ -d fix8/src/nar/resources/noarch/include/fix8 ]; then
    rm -rf fix8/src/nar/resources/noarch/include/fix8
fi
if [ -d fix8/src/nar/resources/noarch/include/Poco ]; then
    rm -rf fix8/src/nar/resources/noarch/include/Poco
fi

mkdir -p fix8/src/nar/resources/noarch/include
cp -Rp ${SRC_INC}/fix8 fix8/src/nar/resources/noarch/include/
cp -p ${SRC_INC}/fix8/f8config.h fix8/src/nar/resources/noarch/include/fix8/f8config_msvc.h
cp -p ./f8config.h fix8/src/nar/resources/noarch/include/fix8/
cp -Rp ${POCO_LINUX}/include/Poco fix8/src/nar/resources/noarch/include/
cp -Rp ${TBB_INC} fix8/src/nar/resources/noarch/include/

if [ -d fix8/src/nar/resources/aol/${AOL_WIN}/lib ]; then
    rm fix8/src/nar/resources/aol/${AOL_WIN}/lib/*
fi
mkdir -p fix8/src/nar/resources/aol/${AOL_WIN}/lib

#for p in expatd.dll fix8d.dll LIBEAY32.dll libeay32.lib pcred.dll PocoCrypto PocoFundation PocoJSON PocoNet PocoNetSSL PocoUtil PocoXML SSLEAT32 ssleay32 tbb tbbmalloc_proxy zlibd1 
for p in pcre PocoCrypto PocoFoundation PocoJSON PocoNet PocoNetSSL PocoUtil PocoXML 
do
    cp -p ${SRC_LIB}/Debug/${p}d.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_LIB}/Release/${p}.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${DEPEND_PKG}/debug/lib/${p}d.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${DEPEND_PKG}/lib/${p}.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/
done

for p in tbb tbbmalloc tbbmalloc_proxy
do
    cp -p ${SRC_LIB}/Debug/${p}_debug.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_LIB}/Release/${p}.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${DEPEND_PKG}/debug/lib/${p}_debug.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${DEPEND_PKG}/lib/${p}.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/
done

cp -p ${SRC_LIB}/Release/LIBEAY32.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Release/SSLEAY32.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Debug/zlibd1.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Release/zlib1.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Debug/expatd.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/

cp -p ${SRC_LIB}/Debug/fix8d.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Release/fix8.dll fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Debug/fix8d.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/fix8-${VERSION}d.lib
cp -p ${SRC_LIB}/Debug/fix8d.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/
cp -p ${SRC_LIB}/Release/fix8.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/fix8-${VERSION}.lib
cp -p ${SRC_LIB}/Release/fix8.lib fix8/src/nar/resources/aol/${AOL_WIN}/lib/

if [ -d ${SRC_LINUX} ]; then
    cp -p ${SRC_LINUX}/include/fix8/f8config.h fix8/src/nar/resources/noarch/include/fix8/f8config_linux.h
    if [ -d fix8/src/nar/resources/aol/${AOL_LINUX}/lib ]; then
        rm fix8/src/nar/resources/aol/${AOL_LINUX}/lib/*
    fi
    mkdir -p fix8/src/nar/resources/aol/${AOL_LINUX}/lib
	
    cp -p ${SRC_LINUX}/lib/libfix8.so.1.0.4 fix8/src/nar/resources/aol/${AOL_LINUX}/lib/libfix8.so.1
    cp -p ${SRC_LINUX}/lib/libfix8.so.1.0.4 fix8/src/nar/resources/aol/${AOL_LINUX}/lib/libfix8-${VERSION}.so
    if [ -d ${POCO_LINUX} ]; then
        for p in libPocoFoundation.so libPocoJSON.so libPocoNet.so libPocoUtil.so libPocoXML.so
        do	
            cp -p ${POCO_LINUX}/lib64/${p}.* fix8/src/nar/resources/aol/${AOL_LINUX}/lib/
        done
    fi
fi

# FIX8-exec
if [ -d ${SRC_LINUX} ]; then
    if [ -d fix8-exec/src/nar/resources/aol/${AOL_LINUX}/bin ]; then
        rm fix8-exec/src/nar/resources/aol/${AOL_LINUX}/bin/*
    fi
    mkdir -p fix8-exec/src/nar/resources/aol/${AOL_LINUX}/bin
    cp -p ${SRC_LINUX}/bin/f8c fix8-exec/src/nar/resources/aol/${AOL_LINUX}/bin/
fi

#!/bin/bash

export VERSION=3.6.3
export VERSUF=36
export SRC=/c/Ice-${VERSION}
export SRC_INC=${SRC}/include
export SRC_LIB=${SRC}/lib/x64
export SRC_BIN=${SRC}/bin/x64
export SRC_LLIB=${SRC}/linuxlib
export SRC_LBIN=${SRC}/linuxlib/bin
export AOL_WIN=amd64-Windows-msvc
export AOL_LINUX=amd64-Linux-gpp

for p in Glacier2 Ice IceStorm IceUtil
do
    echo "Preparing ${p} ..."
    # headers
    if [ -d ${SRC_INC}/${p} ]; then
        if [ -d ${p}/src/nar/resources/noarch/include/${p} ]; then
            rm -rf ${p}/src/nar/resources/noarch/include/${p}
        fi
        mkdir -p ${p}/src/nar/resources/noarch/include
        cp -Rp ${SRC_INC}/${p} ${p}/src/nar/resources/noarch/include/
    fi
    
    pl=${p,,}
    # windows lib
    if [ -d ${pl}/src/nar/resources/aol/${AOL_WIN}/lib ]; then
        rm ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/*
    fi
    mkdir -p ${pl}/src/nar/resources/aol/${AOL_WIN}/lib

    cp -p ${SRC_LIB}/${pl}-${VERSION}*.lib ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_BIN}/${pl}${VERSUF}*.dll ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    
    # linux
    if [ -d ${SRC_LLIB} ]; then
        echo "Preparing Linux ${p} ..."
        if [ -d ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib ]; then
            rm ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib/*
        fi
        mkdir -p ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib
        cp -p ${SRC_LLIB}/lib${p}.so ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}-${VERSION}.so
    fi
    
    if [ "${pl}" = "ice" ]; then
        echo "Preparing Ice additional libraries..."
        cp -p ${SRC_BIN}/bzip2*.dll ${SRC_BIN}/icebox*.dll ${SRC_BIN}/slice*.dll ${SRC_BIN}/icegrid*.dll ${SRC_BIN}/icestormservice*.dll ${SRC_BIN}/icepatch2*.dll ${SRC_BIN}/freeze*.dll ${SRC_BIN}/icexml*.dll ${SRC_BIN}/icessl*.dll ice/src/nar/resources/aol/${AOL_WIN}/lib/
    
        if [ -d ${SRC_LLIB} ]; then
            echo "Preparing Linux Ice additional libraries..."
            cp -p ${SRC_LLIB}/libIce.so.${VERSUF} ${SRC_LLIB}/libIceBox.so.${VERSUF} ${SRC_LLIB}/libSlice.so.${VERSUF} ${SRC_LLIB}/libIceUtil.so.${VERSUF} ${SRC_LLIB}/libIceGrid.so.${VERSUF} ${SRC_LLIB}/libIceStorm.so.${VERSUF} ${SRC_LLIB}/libIceStormService.so.${VERSUF} ${SRC_LLIB}/libIcePatch2.so.${VERSUF} ${SRC_LLIB}/libFreeze.so.${VERSUF} ${SRC_LLIB}/libIceXML.so.${VERSUF} ${SRC_LLIB}/libIceSSL.so.${VERSUF} ${SRC_LLIB}/libGlacier2.so.${VERSUF} ${SRC_LLIB}/libdb_cxx-5.3.so ice/src/nar/resources/aol/${AOL_LINUX}/lib/
        fi
    fi
    
done

# ice-exec
echo "Preparing ice-exec ..."
if [ -d ice-exec/src/nar/resources/aol/${AOL_WIN}/bin ]; then
    rm ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/*
fi
mkdir -p ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/
cp -p ${SRC_BIN}/icebox.exe ${SRC_BIN}/slice2cpp.exe ${SRC_BIN}/icestormadmin.exe ${SRC_BIN}/icegridadmin.exe ${SRC_BIN}/icegridnode.exe ${SRC_BIN}/icegridregistry.exe ${SRC_BIN}/glacier2router.exe ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/

if [ -d ${SRC_LBIN} ]; then
    if [ -d ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin ]; then
    rm ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/*
    fi
    mkdir -p ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/
    cp -p ${SRC_LBIN}/icebox ${SRC_LBIN}/slice2cpp ${SRC_LBIN}/icestormadmin ${SRC_LBIN}/icegridadmin ${SRC_LBIN}/icegridnode ${SRC_LBIN}/icegridregistry ${SRC_LBIN}/glacier2router ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/
fi

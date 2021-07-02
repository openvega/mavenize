#!/bin/bash

export VERSION=3.7.5
export MINORVER=.1
export VERSUF=37
export SRC=/c/Ice-${VERSION}
export SRC_INC=${SRC}/include
export CPP11=++11
export SRC_NAME=${VERSUF}${CPP11}
export SRC_LIB=${SRC}/lib/x64
export SRC_BIN=${SRC}/bin/x64
export SRC_TOOLS=${SRC_BIN}/Release
export SRC_LLIB=${SRC}/linuxlib/lib64
export SRC_LBIN=${SRC}/linuxlib/bin
export AOL_WIN=amd64-Windows-msvc
export AOL_LINUX=amd64-Linux-gpp

for p in Ice IceStorm
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

    cp -p ${SRC_LIB}/Release/${pl}${SRC_NAME}.lib ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_BIN}/Release/${pl}${SRC_NAME}.dll ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_LIB}/Debug/${pl}${SRC_NAME}d.lib ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    cp -p ${SRC_BIN}/Debug/${pl}${SRC_NAME}d.dll ${pl}/src/nar/resources/aol/${AOL_WIN}/lib/
    
    # linux
    if [ -d ${SRC_LLIB} ]; then
        echo "Preparing Linux ${p} ..."
        if [ -d ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib ]; then
            rm ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib/*
        fi
        mkdir -p ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib
        cp -p ${SRC_LLIB}/lib${p}${CPP11}.so ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}-${SRC_NAME}.so
        cp -p ${SRC_LLIB}/lib${p}${CPP11}.so ${pl}/src/nar/resources/aol/${AOL_LINUX}/lib/lib${p}-${SRC_NAME}${MINORVER}.so
    fi
    
    if [ "${pl}" = "ice" ]; then
        echo "Preparing Ice additional libraries..."
        if [ -d ${SRC_INC}/IceUtil ]; then
            cp -Rp ${SRC_INC}/IceUtil ${p}/src/nar/resources/noarch/include/
        fi
        for c in Release
        do
            cp -p ${SRC_BIN}/${c}/bzip2.dll ${SRC_BIN}/${c}/icebox${VERSUF}.dll ${SRC_BIN}/${c}/icegrid${VERSUF}.dll ${SRC_BIN}/${c}/icestormservice${VERSUF}.dll ${SRC_BIN}/${c}/icepatch2${VERSUF}.dll ${SRC_BIN}/${c}/icexml${VERSUF}.dll ${SRC_BIN}/${c}/icessl${VERSUF}.dll ${SRC_BIN}/${c}/icedb${VERSUF}.dll ice/src/nar/resources/aol/${AOL_WIN}/lib/
        done
        for c in Debug Release
        do
            cp -p ${SRC_LIB}/${c}/icediscovery${SRC_NAME}*.lib ${SRC_LIB}/${c}/icelocatordiscovery${SRC_NAME}*.lib ${SRC_LIB}/${c}/icessl${SRC_NAME}*.lib ice/src/nar/resources/aol/${AOL_WIN}/lib/
        done
        if [ -d ${SRC_LLIB} ]; then
            echo "Preparing Linux Ice additional libraries..."
            cp -p ${SRC_LLIB}/libIce${CPP11}.so.${VERSUF} ${SRC_LLIB}/libIceStorm${CPP11}.so.${VERSUF} ${SRC_LLIB}/libIce.so.${VERSUF} ${SRC_LLIB}/libIceBox.so.${VERSUF} ${SRC_LLIB}/libIceGrid.so.${VERSUF} ${SRC_LLIB}/libIceStorm.so.${VERSUF} ${SRC_LLIB}/libIceStormService.so.${VERSUF} ${SRC_LLIB}/libIcePatch2.so.${VERSUF} ${SRC_LLIB}/libIceXML.so.${VERSUF} ${SRC_LLIB}/libIceSSL.so.${VERSUF} ${SRC_LLIB}/libGlacier2.so.${VERSUF} ${SRC_LLIB}/libIceDB.so.${VERSUF} ice/src/nar/resources/aol/${AOL_LINUX}/lib/
        fi
    fi
    
done

# ice-exec
echo "Preparing ice-exec ..."
if [ -d ice-exec/src/nar/resources/aol/${AOL_WIN}/bin ]; then
    rm ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/*
fi
mkdir -p ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/
cp -p ${SRC_TOOLS}/slice2cpp.exe ${SRC_BIN}/Release/icebox.exe ${SRC_BIN}/Release/icegridadmin.exe ${SRC_BIN}/Release/icegridnode.exe ${SRC_BIN}/Release/icegridregistry.exe ice-exec/src/nar/resources/aol/${AOL_WIN}/bin/

if [ -d ${SRC_LBIN} ]; then
    if [ -d ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin ]; then
    rm ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/*
    fi
    mkdir -p ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/
    cp -p ${SRC_LBIN}/slice2cpp ${SRC_LBIN}/icebox ${SRC_LBIN}/icegridadmin ${SRC_LBIN}/icegridnode ${SRC_LBIN}/icegridregistry ice-exec/src/nar/resources/aol/${AOL_LINUX}/bin/
fi

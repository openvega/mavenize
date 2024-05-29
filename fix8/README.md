A. Windows
1. Build Fix8 base on https://fix8engine.atlassian.net/wiki/spaces/FX/pages/9863184/Building+and+running+on+Windows (on a nuget accessible host)

B. Linux
2. Build Poco https://pocoproject.org/download.html#building
2.1 cd to poco_installation_path 
    ln -s lib64 lib
3. fix8 - https://fix8engine.atlassian.net/wiki/spaces/FX/pages/360472/2.+Installation
3.1 Add poco_installation_path/lib to LD_LIBRARY_PATH
[fix8]$ ./bootstrap
[fix8]$ ./configure --prefix=INSTALL_PATH --with-poco=POCO_PATH_IN_2 --with-thread=stdthread
# OBSOLETED 3.1 add -lPocoXML to POCO_LIBS in compiler/Makefile
3.2 add poco lib to LD_LIBRARY_PATH
3.3 build
[fix8]$ make && make install

4. mvn
4.1 bash prepare.sh
4.2 comment out the following in src\nar\resources\noarch\include\fix8\f8config_msvc.h
//#ifndef FIX8_HAVE_OPENSSL
//#define FIX8_HAVE_OPENSSL 1
//#endif
4.3 mvn clean deploy

5. use f8c to gen code on LINUX (once per FIX session definition update)
5.1 f8c has mavenized in fix8-exec
5.2 example: GJPB fix spec
> f8c -p gjpb -n gjpb -c client FIX42-GJPB.xml
5.3 gen another set of code on WINDOWS, only take gjpb_classes.hpp and "merge" to Linux codes:
rename windows: gjpb_classes_msvc.hpp
rename linux: gjpb_classes_linux.hpp
create gjpb_classes.hpp:

#pragma once

#ifdef _MSC_VER
#include <gjpb_classes_msvc.hpp>
#else
#include <gjpb_classes_linux.hpp>
#endif



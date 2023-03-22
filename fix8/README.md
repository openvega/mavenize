A. Windows
1. Build Fix8 base on https://fix8engine.atlassian.net/wiki/spaces/FX/pages/9863184/Building+and+running+on+Windows

B. Linux
2. Build Poco 
3. build fix8 with installed Poco https://fix8engine.atlassian.net/wiki/spaces/FX/pages/360472/2.+Installation

4. prepare and package
4.1 Copy Poco headers from linux to src\nar\resources\noarch\include
4.2 Copy fix8 headers from linux build to src\nar\resources\noarch\include
4.2.1 renamae src\nar\resources\noarch\include\fix8\f8config.h as f8config_linux.h
4.2.2 copy .\f8config.h to src\nar\resources\noarch\include\fix8\
4.3 Copy f8config_msvc.h from windows build to src\nar\resources\noarch\include\fix8\
4.4 Copy tbb headers from windows build msvc\packages\fix8.deps.XXXXX\installed\x64-windows\include\tbb to src\nar\resources\noarch\include\

5.1  copy expat[d].dll fix8[d].dll LIBEAY32.dll libeay32.lib pcre[d].dll PocoCrypto[d].[dll|lib] PocoFundation[d].[dll|lib] PocoJSON[d].dll PocoNet[d].[dll|lib] PocoNetSSL[d].[dll|lib] PocoUtil[d].[dll|lib] PocoXML[d].[dll|lib] SSLEAT32.dll ssleay32.lib tbb[_debug].[dll|lib] tbbmalloc_proxy[_debug].[dll|lib] zlib[d]1.dll and fix8.lib -> src/nar/resources/aol/amd64-Windows-msvc/lib/fix8-${VERSION}.lib
5.2  copy libPocoFoundation.so.86 libPocoJSON.so.86 libPocoNet.so.86 libPocoUtil.so.86 libPocoXML.so.86 libfix8.so.1.0.4 as libfix8.so.1 and make a copy as libfix8-${VERSION}.so to src\nar\resources\aol\amd64-Linux-gpp\lib

// This pyconfig.h is patched, it switch between Windows and Linux

#ifdef _MSC_VER
#include "pyconfig-win.h"
#else
#include <bits/wordsize.h>

#if __WORDSIZE == 32
#include "pyconfig-32.h"
#elif __WORDSIZE == 64
#include "pyconfig-64.h"
#else
#error "Unknown word size"
#endif

#endif
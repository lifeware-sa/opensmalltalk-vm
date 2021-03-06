
#ifndef __PTREADEDPLUGIN__
#define __PTREADEDPLUGIN__

#define true 1
#define false 0
#define null 0

#include <stdio.h>
#include <ffi.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

#include "pharovm/pharo.h"

#include "callbacks.h"
#include "pharovm/semaphores/platformSemaphore.h"
#include "pharovm/macros.h"

//#include "cogmethod.h"

#include "pharovm/interpreter.h"

#include "pThreadedFFIUtils.h"

#ifndef FFI_OK
#define FFI_OK 0
#endif

#endif

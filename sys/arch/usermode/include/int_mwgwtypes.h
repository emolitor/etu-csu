/* $NetBSD: int_mwgwtypes.h,v 1.11 2013/11/10 19:52:01 jmcneill Exp $ */

/*
 * Automatically generated by genheaders.sh on Sun Nov 10 15:47:58 AST 2013
 * Do not modify directly!
 */
#ifndef _USERMODE_INT_MWGWTYPES_H
#define _USERMODE_INT_MWGWTYPES_H

#if defined(__i386__)
#include "../../i386/include/int_mwgwtypes.h"
#elif defined(__x86_64__)
#include "../../amd64/include/int_mwgwtypes.h"
#elif defined(__arm__)
#include "../../arm/include/int_mwgwtypes.h"
#else
#error port me
#endif

#endif

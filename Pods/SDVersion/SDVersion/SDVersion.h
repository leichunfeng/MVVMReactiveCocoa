//
//  SDVersion.h
//  SDVersion
//
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#ifndef SDVersion_h
#define SDVersion_h

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    #import "SDiOSVersion.h"
    #define SDVersion SDiOSVersion
#else
    #import "SDMacVersion.h"
    #define SDVersion SDMacVersion
#endif

#endif

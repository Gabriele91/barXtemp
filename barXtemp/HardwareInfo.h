//
//  HardwareInfo.h
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#ifndef SystryTemp_HardwareInfo_h
#define SystryTemp_HardwareInfo_h

#include <stdbool.h>

typedef struct
{
    //cpu info
    double mCpuTemp;
    //gpu info
    bool mHasGpu;
    double mGpuTemp;
    //battery info
    bool mHasBattery;
    double mBatteryTemp;
    //fan info
    unsigned int mCountFans;
    double* mFansTemp;
    
} HardwareInfo;

HardwareInfo* getHardwareInfo(void);
void freeHardwareInfo(HardwareInfo*);

#endif

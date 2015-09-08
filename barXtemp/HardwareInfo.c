//
//  HardwareInfo.c
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include "HardwareInfo.h"
#include <libkern/OSAtomic.h>
#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/ps/IOPSKeys.h>
#include <IOKit/ps/IOPowerSources.h>
#include "smc.h"
#define EPSILON 0.001
//get hw info
HardwareInfo* getHardwareInfo()
{
    HardwareInfo* hinfo=(HardwareInfo*)calloc(1,sizeof(HardwareInfo));
    SMCOpen();
    //get cpu temperature
    hinfo->mCpuTemp = SMCGetTemperature(SMC_KEY_CPU_TEMP);
    //get gpu temperature
    hinfo->mGpuTemp = SMCGetTemperature(SMC_KEY_GPU_TEMP);
    if(hinfo->mGpuTemp  < EPSILON)   hinfo->mGpuTemp = SMCGetTemperature(SMC_KEY_GPU_DIODE_TEMP);
    if(hinfo->mGpuTemp >= EPSILON)  hinfo->mHasGpu  = true;
    //mac has battery?
    hinfo->mHasBattery = hasBattery();
    //get battery temperature
    if(hinfo->mHasBattery)
    {
       hinfo->mBatteryTemp =  SMCGetTemperature(SMC_KEY_BATTERY_TEMP);
    }
    //get fans temperature
    hinfo->mCountFans = SMCGetFanNumber(SMC_KEY_FAN_NUM);
    //only if have a fan
    if(hinfo->mCountFans)
    {
        //alloc
        hinfo->mFansTemp = (double*)calloc(hinfo->mCountFans, sizeof(double));
        //get info
        for(unsigned int i=0;i!=hinfo->mCountFans;++i)
        {
            hinfo->mFansTemp[i] = SMCGetFanSpeed(i);
        }
    }
    SMCClose();
    return hinfo;
}
//dealloc hw info
void freeHardwareInfo(HardwareInfo* hinfo)
{
    if(hinfo->mFansTemp) free(hinfo->mFansTemp);
    free(hinfo);
}
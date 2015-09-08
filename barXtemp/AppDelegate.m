//
//  AppDelegate.m
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#import "AppDelegate.h"
#import "AppKit/AppKit.h"
#include "HardwareInfo.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)selectMenu
{
    [self updateMenu];
    [item popUpStatusItemMenu:menu];
}

- (void)selectExit
{
    exit(0);
}

- (void) buildMenu
{
    //get info
    HardwareInfo* info=getHardwareInfo();
    //alloc menu
    menu = [[NSMenu alloc] init];
    [menu setAutoenablesItems:NO];
    //add items cpu
    itemTemperature=[[NSMenuItem alloc] init];
    [itemTemperature setEnabled:NO];
    [menu addItem:itemTemperature];
    //add items gpu
    if(info->mHasGpu)
    {
        itemTemperatureGpu=[[NSMenuItem alloc] init];
        [itemTemperatureGpu setEnabled:NO];
        [menu addItem:itemTemperatureGpu];
    }
    else
    {
        itemTemperatureGpu=nil;
    }
    //add item battery
    if(info->mHasBattery)
    {
        itemTemperatureBattery=[[NSMenuItem alloc] init];
        [itemTemperatureBattery setEnabled:NO];
        [menu addItem:itemTemperatureBattery];
    }
    else
    {
        itemTemperatureBattery=nil;
    }
    //list of item fands
    itemsFan = [[NSMutableArray alloc] init];
    //add fans
    for(int i=0;i!=info->mCountFans;++i)
    {
        NSMenuItem* itemFan=[[NSMenuItem alloc] init];
        [itemFan setEnabled:NO];
        [menu addItem:itemFan];
        [itemsFan addObject:itemFan];
    }
    //add separetor
    [menu addItem:[NSMenuItem separatorItem]];
    //create exit item
    itemExit=[[NSMenuItem alloc] initWithTitle:@("Exit")
                                        action:@selector(selectExit)
                                 keyEquivalent:@("")];
    //add exit
    [menu addItem:itemExit];
    //dealloc info
    freeHardwareInfo(info);
}

- (void) updateMenu
{
    //get info
    HardwareInfo* info=getHardwareInfo();
    //set temperature cpu
    itemTemperature.title = [NSString stringWithFormat:@"CPU temperature\t:  %1.2f °C",info->mCpuTemp];
    //set temperature gpu
    if(itemTemperatureGpu)
    {
        itemTemperatureGpu.title = [NSString stringWithFormat:@"GPU temperature\t:  %1.2f °C",info->mGpuTemp];
    }
    //get temperature battery
    if(itemTemperatureBattery)
    {
        itemTemperatureBattery.title = [NSString stringWithFormat:@"Battery temperature\t:  %1.2f °C",info->mBatteryTemp];
    }
    //for all fans
    for(int i=0;i!=info->mCountFans;++i)
    {
        NSMenuItem* itemFan = [itemsFan objectAtIndex:i];
        itemFan.title = [NSString stringWithFormat:@"Fan %d speed \t\t:  %1.2f RPM",i+1,info->mFansTemp[i]];
    }
    //dealloc info
    freeHardwareInfo(info);
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStatusBar* bar=[NSStatusBar systemStatusBar];
    //path image
    NSString* pathImageW=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/thermometer16-white.png"];
    NSString* pathImageD=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/thermometer16-dark.png"];
    //load image
    imageWhite=[[NSImage alloc] initWithContentsOfFile:pathImageW];
    [imageWhite setTemplate:YES];
    imageDark=[[NSImage alloc] initWithContentsOfFile:pathImageD];
    [imageDark setTemplate:YES];
    //get item
    item = [bar statusItemWithLength: -1];
    [item setImage: imageDark];
    [item setAlternateImage:imageWhite];
    [item setAction: @selector(selectMenu)];
    [item setTarget: self];
    //build ui menu
    [self buildMenu];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end

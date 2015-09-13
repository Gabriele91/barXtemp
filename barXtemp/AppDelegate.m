//
//  AppDelegate.m
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#import "AppDelegate.h"
#import "AppKit/AppKit.h"
#import "LoginItems.h"
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
    [NSApp terminate:nil];
}

- (void)selectLogin
{
    if ([LoginItems containsThisApp:@"barXtemp"])
    {
        [LoginItems removeThisApp:@"barXtemp"];
        [itemLogin setState:NSOffState];
    }
    else
    {
        [LoginItems addThisApp:@"barXtemp"];
        [itemLogin setState:NSOnState];
    }
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
    //create loginItem item
    itemLogin=[[NSMenuItem alloc] initWithTitle:@("Start at login")
                                         action:@selector(selectLogin)
                                  keyEquivalent:@("")];
    //image paths
    NSString* pathImgCheckB=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/checkBlack.tiff"];
    NSString* pathImgUncheckB=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/uncheckBlack.tiff"];
    //load image
    imageCheckB=[[NSImage alloc] initWithContentsOfFile:pathImgCheckB];
    [imageCheckB setTemplate:YES];
    imageUncheckB=[[NSImage alloc] initWithContentsOfFile:pathImgUncheckB];
    [imageCheckB setTemplate:YES];
    //set image
    [itemLogin setOnStateImage:imageCheckB];
    [itemLogin setOffStateImage:imageUncheckB];
    //set state
    if ([LoginItems containsThisApp:@"barXtemp"])
    {
        [itemLogin setState:NSOnState];
    }
    else
    {
        [itemLogin setState:NSOffState];
    }
    //add exit
    [menu addItem:itemLogin];
    //add separetor
    [menu addItem:[NSMenuItem separatorItem]];
    //create exit item
    itemExit=[[NSMenuItem alloc] initWithTitle:@("Quit barXtemp")
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

- (BOOL) isInsideApplicationDirectory
{
    NSString* path=[[NSBundle mainBundle] bundlePath];
    return [path containsString:@"Applications/barXtemp"];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //put application at login
    if([self isInsideApplicationDirectory] && ![LoginItems containsThisApp:@"barXtemp"])
    {
        [LoginItems addThisApp:@"barXtemp"];
    }
    //
    NSStatusBar* bar=[NSStatusBar systemStatusBar];
    //path image
    NSString* pathImageW=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/tempWhite.tiff"];
    NSString* pathImageD=
    [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],  @"assets/tempDark.tiff"];
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

//
//  AppDelegate.h
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject<NSApplicationDelegate>
{
    //item in sys menu
    NSStatusItem* item;
    //image in sys menu
    NSImage* imageWhite;
    NSImage* imageDark;
    //image check item
    NSImage* imgCheckB;
    NSImage* imgUncheckB;
    //menu object
    NSMenu* menu;
    //menu items
    NSMenuItem* itemTemperature;
    NSMenuItem* itemTemperatureGpu;
    NSMenuItem* itemTemperatureBattery;
    NSMutableArray* itemsFan;
    NSMenuItem* itemLogin;
    NSMenuItem* itemExit;
}

- (void) buildMenu;
- (void) updateMenu;

@end


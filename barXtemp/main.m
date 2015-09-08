//
//  main.m
//  SystryTemp
//
//  Created by Gabriele Di Bari on 07/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[])
{
    NSApplication* app=[NSApplication sharedApplication] ;
    AppDelegate* delegate = [[AppDelegate alloc] init];
    [app setDelegate:delegate];
    [app run];
    return YES;
}

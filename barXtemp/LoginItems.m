//
//  LoginItems.m
//  barXtemp
//
//  Created by Gabriele Di Bari on 10/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginItems.h"

@implementation LoginItems

+ (BOOL) containsThisApp: (NSString*) appname
{
    
    NSString* script = [NSString stringWithFormat:
    @"tell application \"System Events\"\n"
      "   get the name of every login item\n"
      "   if login item \"%@\" exists then\n"
      "       return true\n"
      "   end if\n"
     "end tell\n"
    "return false",
    appname];
    
    NSDictionary *errorInfo = nil;
    NSAppleScript* aScript=[[NSAppleScript alloc] initWithSource:script];
    NSString* result=[[aScript executeAndReturnError:&errorInfo] stringValue];
    
    if  (result)
    {
        return [result boolValue];
    }
    
    if (errorInfo)
    {
        NSLog(@"Error running applescript (containsThisApp). ");
        //get error id
        id errorId=[errorInfo valueForKey:NSAppleScriptErrorMessage];
        //print error
        if(errorId)
        {
            NSString* errorStr = [errorId stringValue];
            if (errorStr) NSLog(errorStr);
        }
    }
    
    return false;
}

+ (BOOL) removeThisApp: (NSString*) appname
{
    
    NSString* script = [NSString stringWithFormat:
                        @"tell application \"System Events\"\n"
                        "   get the name of every login item\n"
                        "   if login item \"%@\" exists then\n"
                        "       delete login item \"%@\"\n"
                        "   end if\n"
                        "end tell",
                        appname,
                        appname];
    
    NSDictionary *errorInfo = nil;
    NSAppleScript* aScript=[[NSAppleScript alloc] initWithSource:script];
    NSString* result=[[aScript executeAndReturnError:&errorInfo] stringValue];
    
    if  (result)
    {
        return true;
    }
    
    if (errorInfo)
    {
        NSLog(@"Error running applescript (containsThisApp). ");
        //get error id
        id errorId=[errorInfo valueForKey:NSAppleScriptErrorMessage];
        //print error
        if(errorId)
        {
            NSString* errorStr = [errorId stringValue];
            if (errorStr) NSLog(errorStr);
        }
    }
    
    return false;
}

+ (BOOL) addThisApp: (NSString*) appname
{
    
    
    NSString* script = [NSString stringWithFormat:
                        @"set app_path to path to me\n"
                        "tell application \"System Events\"\n"
                        "   if \"%@\" is not in (name of every login item) then\n"
                        "       make login item at end with properties {hidden:false, path:app_path}\n"
                        "   end if\n"
                        "end tell",
                        appname];
    
    NSDictionary *errorInfo = nil;
    NSAppleScript* aScript=[[NSAppleScript alloc] initWithSource:script];
    NSString* result=[[aScript executeAndReturnError:&errorInfo] stringValue];
    
    if  (result)
    {
        return true;
    }
    
    if (errorInfo)
    {
        NSLog(@"Error running applescript (containsThisApp). ");
        //get error id
        id errorId=[errorInfo valueForKey:NSAppleScriptErrorMessage];
        //print error
        if(errorId)
        {
            NSString* errorStr = [errorId stringValue];
            if (errorStr) NSLog(errorStr);
        }
    }
    
    return false;
}

@end
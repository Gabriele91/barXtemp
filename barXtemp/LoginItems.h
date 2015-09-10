//
//  LoginItems.h
//  barXtemp
//
//  Created by Gabriele Di Bari on 10/09/15.
//  Copyright (c) 2015 Gabriele Di Bari. All rights reserved.
//

#ifndef barXtemp_LoginItems_h
#define barXtemp_LoginItems_h

@interface LoginItems : NSObject
{
}

+ (BOOL) containsThisApp: (NSString*) appname;
+ (BOOL) removeThisApp: (NSString*) appname;
+ (BOOL) addThisApp: (NSString*) appname;

@end

#endif

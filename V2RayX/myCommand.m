//
//  myCommand.m
//  V2RayX
//
//  Created by MeLody on 2022/3/3.
//  Copyright © 2022 Project V2Ray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

extern AppDelegate *appDelegate;

@interface myCommand : NSScriptCommand
@end

@implementation myCommand : NSScriptCommand

- (id) performDefaultImplementation {
    BOOL previousStatus = appDelegate.proxyState;
    dispatch_async(dispatch_get_main_queue(), ^{
        appDelegate.proxyState = !previousStatus;
        [appDelegate changeStatus:previousStatus state:!previousStatus];
    });
    NSUserNotification *n = [[NSUserNotification alloc] init];
    n.title = @"V2RayX Toggle";
    n.informativeText = [@"Current State " stringByAppendingFormat: previousStatus? @"OFF": @"ON"];
    [NSUserNotificationCenter.defaultUserNotificationCenter deliverNotification:n];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    
    return n.informativeText;
}
@end

//
//  AppDelegate.m
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import "AppDelegate.h"
#import "MCAppManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[MCAppManager sharedInstance] startListening];
//    MCMouseKeyboardController *contrl = [MCMouseKeyboardController new];
//    [contrl mouseHoldLeft];
//    for (int i = 0; i < 300; i++) {
//
//        [contrl moveMouseOneUnitLeft];
//        [contrl moveMouseOneUnitUP];
//    }
//    [contrl mouseReleaseLeft];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

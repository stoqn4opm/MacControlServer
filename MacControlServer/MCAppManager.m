//
//  MCAppManager.m
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import "MCAppManager.h"

@implementation MCAppManager
+ (MCAppManager *)sharedInstance {
    static MCAppManager *sharedInstance = nil;
    static dispatch_once_t onceToken; // onceToken = 0
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MCAppManager alloc] init];
        
    });
    
    return sharedInstance;
}
@end

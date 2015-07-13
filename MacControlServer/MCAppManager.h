//
//  MCAppManager.h
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket/GCDAsyncSocket.h"
#import "MouseKeyboardController/MCMouseKeyboardController.h"

@interface MCAppManager : NSObject
+ (MCAppManager *)sharedInstance;

@property (nonatomic, strong) GCDAsyncSocket *listeningSocket;
@property (nonatomic, strong) NSMutableArray *clientSockets;

@property (nonatomic, strong) MCMouseKeyboardController *eventsController;
@end

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

// Config
#define TIMEOUT 5000
#define PORT    2222

/*
 This parameter sets how many pixels will be skipped on a single move message received
 Try to keep it low (preferably =1, so that it moves one pixel at a time), because it
 can make cursor movement looks like it skipping frames
 */
#define SENSITIVITY 1
// Communication Protocol
#define MESSAGE_SEPERATOR [GCDAsyncSocket CRLFData]

#define MOVE_UP_MESSAGE         @"coord:y=1\x0D\x0A"
#define MOVE_DOWN_MESSAGE       @"coord:y=-1\x0D\x0A"
#define MOVE_LEFT_MESSAGE       @"coord:x=-1\x0D\x0A"
#define MOVE_RIGHT_MESSAGE      @"coord:x=1\x0D\x0A"
#define HOLD_LEFT_MESSAGE       @"click:left=1\x0D\x0A"
#define RELEASE_LEFT_MESSAGE    @"click:left=0\x0D\x0A"
#define HOLD_RIGHT_MESSAGE      @"click:right=1\x0D\x0A"
#define RELEASE_RIGHT_MESSAGE   @"click:right=0\x0D\x0A"


@interface MCAppManager : NSObject <GCDAsyncSocketDelegate>
+ (MCAppManager *)sharedInstance;

@property (nonatomic, strong) GCDAsyncSocket *listeningSocket;
@property (nonatomic, strong) NSMutableArray *clientSockets;

@property (nonatomic, strong) MCMouseKeyboardController *eventsController;

-(BOOL)startListening;
-(void)stopListening;
@end

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

-(BOOL)startListening{
    return [self.listeningSocket acceptOnPort:PORT error:nil];
}

-(void)stopListening{
    [self.listeningSocket disconnect];
}

#pragma mark - property Getters
-(GCDAsyncSocket *)listeningSocket{
    if (_listeningSocket) {
        return _listeningSocket;
    }
    dispatch_queue_t deQ = dispatch_queue_create("com.cydia.mac_control.server.delegate_queue", NULL);
    _listeningSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:deQ];
    [_listeningSocket acceptOnPort:PORT error:nil];
    return _listeningSocket;
}

-(NSMutableArray *)clientSockets{
    if (_clientSockets) {
        return _clientSockets;
    }
    _clientSockets = [NSMutableArray new];
    return _clientSockets;
}

-(MCMouseKeyboardController *)eventsController{
    if (_eventsController) {
        return _eventsController;
    }
    _eventsController = [MCMouseKeyboardController new];
    return _eventsController;
}


#pragma mark - <GCDAsyncSocketDelegate> Methods
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    [self.clientSockets addObject:newSocket];
    [newSocket readDataToData:MESSAGE_SEPERATOR withTimeout:TIMEOUT tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *receivedMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self _handleReceivedMessage:receivedMessage];
    
    [sock readDataToData:MESSAGE_SEPERATOR withTimeout:TIMEOUT tag:0];
}


#pragma mark - Message Handling
-(void)_handleReceivedMessage:(NSString *)message{
    NSLog(@"Handle receive message: %@",message);
    if ([message isEqualToString:MOVE_UP_MESSAGE]){
        [self.eventsController moveMouseOneUnitUP];
    }
    else if ([message isEqualToString:MOVE_DOWN_MESSAGE]){
        [self.eventsController moveMouseOneUnitDown];
    }
    else if ([message isEqualToString:MOVE_LEFT_MESSAGE]){
        [self.eventsController moveMouseOneUnitLeft];
    }
    else if ([message isEqualToString:MOVE_RIGHT_MESSAGE]){
        [self.eventsController moveMouseOneUnitRight];
    }
    else if ([message isEqualToString:HOLD_LEFT_MESSAGE]){
        [self.eventsController mouseHoldLeft];
    }
    else if ([message isEqualToString:HOLD_RIGHT_MESSAGE]){
        [self.eventsController mouseHoldRight];
    }
    else if ([message isEqualToString:RELEASE_LEFT_MESSAGE]){
        [self.eventsController mouseReleaseLeft];
    }
    else if ([message isEqualToString:RELEASE_RIGHT_MESSAGE]){
        [self.eventsController mouseReleaseRight];
    }
    else if ([message integerValue] != 0){
        NSLog(@"%ld",[message integerValue]);
        [self.eventsController pressKey:[message integerValue]];
    }
}
@end

//
//  MCMouseKeyboardController.m
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import "MCMouseKeyboardController.h"

@implementation MCMouseKeyboardController

-(void)moveMouseOneUnitUP{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef moveUP = CGEventCreateMouseEvent(
                                                NULL, kCGEventMouseMoved,
                                                CGPointMake(currMousePos.x, currMousePos.y + 1),
                                                kCGMouseButtonLeft
                                                );
    CGEventPost(kCGHIDEventTap, moveUP);
    CFRelease(moveUP);
    
}

-(void)moveMouseOneUnitDown{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef moveDown = CGEventCreateMouseEvent(
                                                  NULL, kCGEventMouseMoved,
                                                  CGPointMake(currMousePos.x, currMousePos.y - 1),
                                                  kCGMouseButtonLeft
                                                  );
    CGEventPost(kCGHIDEventTap, moveDown);
    CFRelease(moveDown);
    
}

-(void)moveMouseOneUnitLeft{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef moveLeft = CGEventCreateMouseEvent(
                                                  NULL, kCGEventMouseMoved,
                                                  CGPointMake(currMousePos.x - 1, currMousePos.y),
                                                  kCGMouseButtonLeft
                                                  );
    CGEventPost(kCGHIDEventTap, moveLeft);
    CFRelease(moveLeft);
    
}

-(void)moveMouseOneUnitRight{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef moveRight = CGEventCreateMouseEvent(
                                                   NULL, kCGEventMouseMoved,
                                                   CGPointMake(currMousePos.x + 1, currMousePos.y),
                                                   kCGMouseButtonLeft
                                                   );
    CGEventPost(kCGHIDEventTap, moveRight);
    CFRelease(moveRight);
    
}

- (void)mouseHoldLeft{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef holdLeft = CGEventCreateMouseEvent(
                                                  NULL, kCGEventLeftMouseDown,
                                                  CGPointMake(currMousePos.x, currMousePos.y),
                                                  kCGMouseButtonLeft
                                                  );
    CGEventPost(kCGHIDEventTap, holdLeft);
    CFRelease(holdLeft);
}

- (void)mouseHoldRight{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef holdRight = CGEventCreateMouseEvent(
                                                   NULL, kCGEventRightMouseDown,
                                                   CGPointMake(currMousePos.x, currMousePos.y),
                                                   kCGMouseButtonRight
                                                   );
    CGEventPost(kCGHIDEventTap, holdRight);
    CFRelease(holdRight);
}

- (void)mouseReleaseLeft{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef releaseLeft = CGEventCreateMouseEvent(
                                                     NULL, kCGEventLeftMouseUp,
                                                     CGPointMake(currMousePos.x, currMousePos.y),
                                                     kCGMouseButtonLeft
                                                     );
    CGEventPost(kCGHIDEventTap, releaseLeft);
    CFRelease(releaseLeft);
}

- (void)mouseReleaseRight{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef releaseRight = CGEventCreateMouseEvent(
                                                      NULL, kCGEventRightMouseUp,
                                                      CGPointMake(currMousePos.x, currMousePos.y),
                                                      kCGMouseButtonRight
                                                      );
    CGEventPost(kCGHIDEventTap, releaseRight);
    CFRelease(releaseRight);
}

@end

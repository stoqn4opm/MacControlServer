//
//  MCMouseKeyboardController.m
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import "MCMouseKeyboardController.h"
#import "MCAppManager.h"

// C low level function prototyping definition at bottom
CGKeyCode keyCodeForChar(const char c);
CFStringRef createStringForKey(CGKeyCode keyCode);

@implementation MCMouseKeyboardController

-(void)moveMouseOneUnitUP{
    CGEventRef currMouseCordinateEvent = CGEventCreate(NULL);
    CGPoint currMousePos = CGEventGetLocation(currMouseCordinateEvent);
    CFRelease(currMouseCordinateEvent);
    
    CGEventRef moveUP = CGEventCreateMouseEvent(
                                                NULL, kCGEventMouseMoved,
                                                CGPointMake(currMousePos.x, currMousePos.y - SENSITIVITY),
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
                                                  CGPointMake(currMousePos.x, currMousePos.y + SENSITIVITY),
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
                                                  CGPointMake(currMousePos.x - SENSITIVITY, currMousePos.y),
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
                                                   CGPointMake(currMousePos.x + SENSITIVITY, currMousePos.y),
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

-(void)pressKey:(uint16_t)key{
    CGEventRef keyPressEvent = CGEventCreateKeyboardEvent (NULL, keyCodeForChar(key), true);
    CGEventPost(kCGSessionEventTap, keyPressEvent);
    CFRelease(keyPressEvent);
}
@end

#include <CoreFoundation/CoreFoundation.h>
#include <Carbon/Carbon.h> /* For kVK_ constants, and TIS functions. */
/* Returns string representation of key, if it is printable.
 * Ownership follows the Create Rule; that is, it is the caller's
 * responsibility to release the returned object. */
CFStringRef createStringForKey(CGKeyCode keyCode)
{
    TISInputSourceRef currentKeyboard = TISCopyCurrentKeyboardInputSource();
    CFDataRef layoutData =
    TISGetInputSourceProperty(currentKeyboard,
                              kTISPropertyUnicodeKeyLayoutData);
    const UCKeyboardLayout *keyboardLayout =
    (const UCKeyboardLayout *)CFDataGetBytePtr(layoutData);
    UInt32 keysDown = 0;
    UniChar chars[4];
    UniCharCount realLength;
    UCKeyTranslate(keyboardLayout,
                   keyCode,
                   kUCKeyActionDisplay,
                   0,
                   LMGetKbdType(),
                   kUCKeyTranslateNoDeadKeysBit,
                   &keysDown,
                   sizeof(chars) / sizeof(chars[0]),
                   &realLength,
                   chars);
    CFRelease(currentKeyboard);
    return CFStringCreateWithCharacters(kCFAllocatorDefault, chars, 1);
}
/* Returns key code for given character via the above function, or UINT16_MAX
 * on error. */
CGKeyCode keyCodeForChar(const char c)
{
    static CFMutableDictionaryRef charToCodeDict = NULL;
    CGKeyCode code;
    UniChar character = c;
    CFStringRef charStr = NULL;
    /* Generate table of keycodes and characters. */
    if (charToCodeDict == NULL) {
        size_t i;
        charToCodeDict = CFDictionaryCreateMutable(kCFAllocatorDefault,
                                                   128,
                                                   &kCFCopyStringDictionaryKeyCallBacks,
                                                   NULL);
        if (charToCodeDict == NULL) return UINT16_MAX;
        /* Loop through every keycode (0 - 127) to find its current mapping. */
        for (i = 0; i < 128; ++i) {
            CFStringRef string = createStringForKey((CGKeyCode)i);
            if (string != NULL) {
                CFDictionaryAddValue(charToCodeDict, string, (const void *)i);
                CFRelease(string);
            }
        }
    }
    charStr = CFStringCreateWithCharacters(kCFAllocatorDefault, &character, 1);
    /* Our values may be NULL (0), so we need to use this function. */
    if (!CFDictionaryGetValueIfPresent(charToCodeDict, charStr,
                                       (const void **)&code)) {
        code = UINT16_MAX;
    }
    CFRelease(charStr);
    return code;
}
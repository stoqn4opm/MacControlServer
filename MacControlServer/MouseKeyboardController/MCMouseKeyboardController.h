//
//  MCMouseKeyboardController.h
//  MacControlServer
//
//  Created by Stoyan Stoyanov on 7/13/15.
//  Copyright (c) 2015 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMouseKeyboardController : NSObject

-(void) moveMouseOneUnitUP;
-(void) moveMouseOneUnitDown;
-(void) moveMouseOneUnitLeft;
-(void) moveMouseOneUnitRight;

-(void) mouseHoldLeft;
-(void) mouseReleaseLeft;
-(void) mouseHoldRight;
-(void) mouseReleaseRight;
-(void) pressKey:(uint16_t)key;
@end

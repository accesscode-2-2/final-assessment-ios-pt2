//
//  MotionGesture.h
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MotionGestureDelegate <NSObject>

-(void)tiltUp;
-(void)tiltDown;

@end


@interface MotionGesture : NSObject
@property (nonatomic, weak) id<MotionGestureDelegate> motionGestureDelegate;

@end
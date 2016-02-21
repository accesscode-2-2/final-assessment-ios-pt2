//
//  MotionGesture.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//



@import CoreMotion;

#import "MotionGesture.h"

static double const TiltDownLimit = 45;
static double const TiltUpLimit = 135;
static double const Buffer = 10;

typedef NS_ENUM(NSUInteger, GestureState) {
    GestureStateNone,
    GestureStateTiltUp,
    GestureStateTiltDown,
};

@interface MotionGesture ()

@property (nonatomic) CMMotionManager *manager;
@property (nonatomic) GestureState gestureState;

@end

@implementation MotionGesture

- (instancetype)init {
    self = [super init];
    if (self) {
        [self generalSetup];
    }
    return self;
}

- (void)setGestureState:(GestureState)gestureState
{
    // So this thing doesn't get called a million times in a second
    if (_gestureState == gestureState) {
        return;
    }
    
    _gestureState = gestureState;
    
    switch (gestureState) {
        case GestureStateNone:
            break;
        case GestureStateTiltUp:
            [self.motionGestureDelegate tiltUp];
            break;
        case GestureStateTiltDown:
            [self.motionGestureDelegate tiltDown];
            break;
            
        default:
            break;
    }
}

-(void)generalSetup {
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.manager = manager;
    
    
    if (manager.deviceMotionAvailable) {
        manager.deviceMotionUpdateInterval = 0.01f;
        [manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion *data, NSError *error) {
                                         //                                         double rotation = atan2(data.gravity.x, data.gravity.y) - M_PI;
                                         double rollDegrees = data.attitude.roll * (180 / M_PI);
                                         
                                         if (rollDegrees < TiltDownLimit) {
                                             self.gestureState = GestureStateTiltDown;
                                         }
                                         else if (rollDegrees > TiltUpLimit) {
                                             self.gestureState = GestureStateTiltUp;
                                         }
                                         else if (rollDegrees > TiltDownLimit + Buffer &&
                                                  rollDegrees < TiltUpLimit - Buffer) {
                                             self.gestureState = GestureStateNone;
                                         }
                                         
//                                         NSLog(@"Roll: %@", @(rollDegrees));
                                         
                                     }];
    }
    
    
}
@end

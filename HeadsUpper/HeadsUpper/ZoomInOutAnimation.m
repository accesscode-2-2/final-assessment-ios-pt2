//
//  ZoomInOutAnimation.m
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "ZoomInOutAnimation.h"

@implementation ZoomInOutAnimation

+ (NSString *)pulseView:(UIImageView *)view from:(float)from to:(float)to withDuration:(float)duration repeats:(int)repeats
{
    CABasicAnimation *pulse;
    pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.fromValue = [NSNumber numberWithFloat:from];
    pulse.toValue = [NSNumber numberWithFloat:to];
    pulse.autoreverses = YES;
    pulse.duration = duration;
    pulse.repeatCount = repeats;
    
    [view.layer addAnimation:pulse forKey:@"pulse"];
    
    return @"pulse";
}

+ (void)stopZoomingView:(UIImageView *)view {
    [view.layer removeAnimationForKey:@"pulse"];
}

@end

//
//  ZoomInOutAnimation.h
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface ZoomInOutAnimation : NSObject
+ (NSString *)pulseView:(UIView *)view from:(float)from to:(float)to withDuration:(float)duration repeats:(int)repeats;

+ (void)stopZoomingView:(UIView *)view;

@end

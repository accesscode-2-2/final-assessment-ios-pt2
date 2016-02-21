//
//  UIColor+FadeColor.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "UIColor+FadeColor.h"

@implementation UIColor (FadeColor)

+ (instancetype)colorForFadeType:(ColorFade)fade{

    switch (fade) {
        case OrangeColor:
            return [UIColor orangeColor];
            break;
        default:
            return [UIColor greenColor];
            break;
    }
}

@end

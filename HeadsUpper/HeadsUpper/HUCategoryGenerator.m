//
//  HUCategoryGenerator.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUCategoryGenerator.h"

@implementation HUCategoryGenerator

+ (HUCategory)categoryForIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return SuperStars;
            break;
        case 1:
            return ThatsSo90s;
            break;
        case 2:
            return HeyMrDJ;
            break;
        case 3:
            return Icons;
            break;
        case 4:
            return AnimalsGoneWild;
            break;
        default:
            return SuperStars;
            break;
    }

}

+ (NSString *)getTitleForCategory:(HUCategory)category{

    switch (category) {
        case SuperStars:
            return @"Superstars";
            break;
        case ThatsSo90s:
            return @"That's So 90s";
            break;
        case HeyMrDJ:
            return @"Hey Mr.DJ";
            break;
        case Icons:
            return @"Icons";
            break;
        case AnimalsGoneWild:
            return @"Animals Gone Wild";
            break;
        default:
            break;
    }
}
@end

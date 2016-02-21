//
//  HUCategoryGenerator.h
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUCategoryGenerator : NSObject

+ (HUCategory)categoryForIndex:(NSUInteger)index;
+ (NSString *)getTitleForCategory:(HUCategory)category;
@end

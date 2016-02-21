//
//  HUClue.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUClue.h"
#import "HUGameCategory.h"

@implementation HUClue


-(instancetype)initWithDescription:(NSString *)description andCategory:(HUGameCategory *)category {
    
    if (self = [super init]) {
        self.description = description;
        self.category = category;
        return  self;
    }
    
    return nil;
}

@end

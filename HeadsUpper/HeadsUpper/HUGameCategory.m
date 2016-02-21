//
//  HUGameCategory.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameCategory.h"

@implementation HUGameCategory 

- (instancetype)initWithName:(NSString *)categoryName andClues:(NSMutableArray<HUClue *> *)clues {
    
    if (self = [super init]) {
        
        self.name = categoryName;
        self.clues = clues;
        
        return self;
    }
    return nil;
}

@end

//
//  HUGameCategory.h
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUClue.h"

@interface HUGameCategory : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray<HUClue *> *clues;

- (instancetype)initWithName:(NSString *)categoryName andClues:(NSMutableArray<HUClue *> *)clues;

@end

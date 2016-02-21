//
//  SubjectsObjectModel.h
//  HeadsUpper
//
//  Created by Bereket  on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectsObjectModel : NSObject

@property (nonatomic) NSMutableArray* animalsGoneWildArray;
@property (nonatomic) NSMutableArray* iconsArray;
@property (nonatomic) NSMutableArray* superStarsArray;
@property (nonatomic) NSInteger scoreCount;

@property (nonatomic) NSInteger topicNumber;

+ (instancetype) sharedManager;

@end

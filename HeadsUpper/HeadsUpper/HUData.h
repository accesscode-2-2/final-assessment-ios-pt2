//
//  HUData.h
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUData : NSObject

@property (nonatomic) NSDictionary *data;

+ (instancetype)sharedData;

- (NSArray *)dataForCategory:(HUCategory)category;

@end

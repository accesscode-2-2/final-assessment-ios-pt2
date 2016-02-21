//
//  HUAPIManager.h
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUAPIManager : NSObject

+ (void)getTitlesAndSubjects:(void(^)(NSArray *data))completion;


@property (nonatomic) NSArray *subjects;

@end

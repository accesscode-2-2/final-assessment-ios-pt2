//
//  GameData.m
//  HeadsUpper
//
//  Created by Brian Blanco on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameData.h"

@implementation GameData


- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        
    }
    return self;
}

+ (id)topicWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

@end

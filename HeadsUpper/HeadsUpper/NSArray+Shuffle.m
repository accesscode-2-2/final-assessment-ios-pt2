//
//  NSArray+Shuffle.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

+ (instancetype)shuffle:(NSArray *)original{
    NSMutableArray *shuffled = [NSMutableArray arrayWithArray:original];

    for (int i = 0; i < shuffled.count; i++) {
        int j = arc4random_uniform((int)shuffled.count);
        id temp = shuffled[j];
        [shuffled replaceObjectAtIndex:j withObject:shuffled[i]];
        [shuffled replaceObjectAtIndex:i withObject:temp];
    }

    return (NSArray *)shuffled;
}

@end

//
//  WorkoutManager.m
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "GameManager.h"
#import "Cards.h"


@implementation GameManager

#pragma mark Singleton Methods

@synthesize gameTopics;

+ (GameManager *) sharedManager{
    static GameManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.gameTopics = [[NSMutableDictionary alloc] init];
        [sharedMyManager preLoadedWorkouts];
    });
    return sharedMyManager;
}


- (void)preLoadedWorkouts {
    
    NSArray *residentEvil = @[@"Jill Valentine",
                             @"Albert Wesker",
                             @"Chris Redfield",
                             @"Leon Kennedy",
                             @"William Birkin",
                             @"Ada Wong",
                             @"Claire Redfield",
                             @"Jake Muller",
                             @"Sherry Birkin",
                             @"Carlos Oliveira",
                             @"Mikhail Victor",
                             @"Nicholai Ginovaef"];

    
    [self.gameTopics setObject:residentEvil forKey:@"Resident Evil"];
    
    
    NSArray *accessCode = @[@"Natalia",
                              @"Elber",
                              @"Christella",
                              @"Charles",
                              @"Mike",
                              @"Max",
                              @"Zouf",
                              @"Jamaal",
                              @"Shena",
                              @"Derek",
                              @"Mesfin"];
    
    
    [self.gameTopics setObject:accessCode forKey:@"Access Code"];
    
    NSArray *cereal = @[@"Lucky Charms",
                        @"Frosted Flakes",
                        @"Cheerios",
                        @"Special K",
                        @"Pebbles",
                        @"Life",
                        @"Apple Jacks",
                        @"Cinammon Toast Crunch",
                        @"Cap n' Crunch",
                        @"Chex",
                        @"Cookie Crisp",
                        @"Honey Graham"];
    
    [self.gameTopics setObject:cereal forKey:@"Cereal"];

}




@end

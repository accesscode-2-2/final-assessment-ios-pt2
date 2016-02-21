//
//  WorkoutManager.h
//  unit-1-final-project
//
//  Created by Fatima Zenine Villanueva on 8/22/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property (nonatomic,strong) NSMutableDictionary *gameTopics;

+ (GameManager *) sharedManager;



@end

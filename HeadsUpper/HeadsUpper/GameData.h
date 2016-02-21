//
//  GameData.h
//  HeadsUpper
//
//  Created by Brian Blanco on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (strong, nonatomic) NSString *title;


- (id)initWithTitle:(NSString *)title;
+ (id) topicWithTitle:(NSString *)title;


@end

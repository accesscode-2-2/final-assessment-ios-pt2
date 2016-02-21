//
//  GameModel.h
//  HeadsUpper
//
//  Created by Shena Yoshida on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic) NSString *category; 
@property (nonatomic) NSArray *items;

- (instancetype)initWithCategoryType:(NSString *)picked;

@end

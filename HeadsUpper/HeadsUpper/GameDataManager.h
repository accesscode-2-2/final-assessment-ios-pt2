//
//  GameTopicDataModel.h
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDataManager : NSObject

@property (nonatomic) NSDictionary *data;

+ (void)getGameDataWithCompletionHander:(void(^)(NSDictionary *gameData))completion;

@end

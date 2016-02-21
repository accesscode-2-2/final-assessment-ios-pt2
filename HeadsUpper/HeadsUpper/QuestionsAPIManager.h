//
//  QuestionsAPIManager.h
//  HeadsUpper
//
//  Created by Elber Carneiro on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsAPIManager : NSObject

+ (void)getQuestionsWithCompletionHandler:(void(^)(NSMutableDictionary *categories))completion;

@end

//
//  GameTopicDataModel.h
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameTopicDataModel : NSObject

@property (nonatomic) NSArray <NSDictionary *> *data;

- (id)initWithLoadCompletionBlock:(void(^)())completion;

@end

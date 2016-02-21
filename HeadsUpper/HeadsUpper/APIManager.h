//
//  APIManager.h
//  HeadsUpper
//
//  Created by Justine Gartner on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

@interface APIManager : NSObject

+ (void) getTopicData:(void(^)(NSDictionary *data))completion;

@end

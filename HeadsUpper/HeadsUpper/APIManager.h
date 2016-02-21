//
//  APIManager.h
//  HeadsUpper
//
//  Created by Daniel Distant on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIManager : NSObject

+ (void) fetchHeadsUpDataWithCompletionBlock:(void (^)(NSArray *data))completionBlock;

@end

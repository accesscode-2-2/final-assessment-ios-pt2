//
//  APIManager.h
//  HeadsUpper
//
//  Created by Artur Lan on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void)findSomething:(NSString *)query
           completion:(void(^)(NSArray *data))completion;

@end

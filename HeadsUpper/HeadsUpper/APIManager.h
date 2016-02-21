//
//  APIManager.h
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject
+ (void)getDataWithCompletion:(void(^)(NSArray *data))completion;

@end

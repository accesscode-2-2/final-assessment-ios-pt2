//
//  APIManager.m
//  HeadsUpper
//
//  Created by Daniel Distant on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (void)fetchHeadsUpDataWithCompletionBlock:(void (^)(NSArray *data))completionBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://heads-up-api.herokuapp.com/" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *response = [[NSArray alloc] initWithArray:responseObject];
        
        NSMutableArray *dicts = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < response.count; i++) {
            NSDictionary *topic = [[NSDictionary alloc] initWithDictionary:response[i] copyItems:YES];
            [dicts addObject:topic];
        }
        
        completionBlock(dicts);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
    
    
}


@end

//
//  APIManager.m
//  HeadsUpper
//
//  Created by Justine Gartner on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "APIManager.h"

@implementation APIManager

+ (void) getTopicData:(void(^)(NSDictionary *data))completion
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://heads-up-api.herokuapp.com/" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject;
        completion(data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
    
}

@end

//
//  HUAPIManager.m
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUAPIManager.h"
#import <AFNetworking/AFNetworking.h>


@implementation HUAPIManager

// https://heads-up-api.herokuapp.com/

+ (void)getTitlesAndSubjects:(void(^)(NSArray *data))completion

{
    NSString *urlString = @"https://heads-up-api.herokuapp.com/";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             completion(responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

@end

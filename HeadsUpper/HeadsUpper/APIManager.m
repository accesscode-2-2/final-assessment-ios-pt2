//
//  APIManager.m
//  HeadsUpper
//
//  Created by Artur Lan on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//
#import "APIManager.h"
#import "Foundation/Foundation.h"
#import <AFNetworking/AFNetworking.h>


@implementation APIManager

+ (void)findSomething:(NSString *)query
           completion:(void(^)(NSArray *data))completion
{
    NSString *baseURL = @"https://heads-up-api.herokuapp.com/";

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:baseURL
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject)
     {
         completion(responseObject[@"title"]);
         NSLog(@"%@", responseObject);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

@end

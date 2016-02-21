//
//  QuestionsAPIManager.m
//  HeadsUpper
//
//  Created by Elber Carneiro on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "QuestionsAPIManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation QuestionsAPIManager

+ (void)getQuestionsWithCompletionHandler:(void(^)(NSMutableDictionary *categories))completion {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://heads-up-api.herokuapp.com/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSArray *responseArray = responseObject;
             NSMutableDictionary *categories = [[NSMutableDictionary alloc] initWithCapacity:responseArray.count];
             for (int i = 0; i < responseArray.count; i++) {
                 
                 [categories setObject:responseArray[i][@"subjects"] forKey:responseArray[i][@"title"]];
             }
             
             completion(categories);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@", error);
         }];
}

@end

//
//  GameTopicDataModel.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameDataManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation GameDataManager

+(void)getGameDataWithCompletionHander:(void(^)(NSDictionary *gameData))completion{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://heads-up-api.herokuapp.com/" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *topicDictionaries = responseObject;
        
        NSMutableDictionary *gameDataModel = [[NSMutableDictionary alloc] init];
        for (int i = 0; i< topicDictionaries.count; i++) {
            
            NSDictionary *topicDictionary = topicDictionaries[i];
            NSString *title = topicDictionary[@"title"];
            NSArray *subjects = topicDictionary[@"subjects"];
            
            [gameDataModel setObject:subjects forKey:title];
        }
        
        NSDictionary *gameDataDictionary = [NSDictionary dictionaryWithDictionary:gameDataModel];
        
        completion(gameDataDictionary);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

@end

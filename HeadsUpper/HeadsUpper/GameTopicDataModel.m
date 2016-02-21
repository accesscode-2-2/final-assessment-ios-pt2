//
//  GameTopicDataModel.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTopicDataModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation GameTopicDataModel


- (id)initWithLoadCompletionBlock:(void(^)())completion
{
    if (self = [super init]) {
        
        GameTopicDataModel *instance = [[GameTopicDataModel alloc] init];
        [instance loadData:completion];
        
        return instance;
    }
    
    return nil;
}

- (void)loadData:(void(^)())completion
{
    __weak typeof(self) weakSelf = self;
    [self getGameDataWithCompletionHander:^(NSArray *gameData) {
        weakSelf.data = gameData;
        completion();
    }];
}

-(void)getGameDataWithCompletionHander:(void(^)(NSArray *gameData))completion{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager GET:@"https://heads-up-api.herokuapp.com/" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        completion(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end

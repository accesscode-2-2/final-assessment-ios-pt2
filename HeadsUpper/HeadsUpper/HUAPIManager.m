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
             // NEED TO LOOP THROUGH THE ARRAY...
             // LOOP THROUGH RESPONSE OBJECT AND GET THE TITLE AND SUBJECTS
             completion(responseObject);
//             for (NSDictionary *dict in responseObject) {
//                 NSLog(@"%@", dict);
//             }
             
             // not sure what I was doing here

//             NSDictionary *superStarsDict = [responseObject objectAtIndex:0];
//             NSString *superStarTitle = [superStarsDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", superStarTitle);
//             NSLog(@"%@", superStarsDict);
//             
//             NSDictionary *ninetiesDict = [responseObject objectAtIndex:1];
//             NSString *ninetiesTitle = [ninetiesDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", ninetiesTitle);
//             NSLog(@"%@", ninetiesDict);
//             
//             NSDictionary *heyMrDJDict = [responseObject objectAtIndex:2];
//             NSString *DJTitle = [heyMrDJDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", DJTitle);
//             NSLog(@"%@", heyMrDJDict);
//             
//             NSDictionary *iconsDict = [responseObject objectAtIndex:3];
//             NSString *iconsString = [iconsDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", iconsString);
//             NSLog(@"%@", iconsDict);
//             
//             NSDictionary *animalsDict = [responseObject objectAtIndex:4];
//             NSString *animalsString = [animalsDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", animalsString);
//             NSLog(@"%@", animalsDict);
//             
//             NSDictionary *moviesDict = [responseObject objectAtIndex:5];
//             NSString *moviesString = [moviesDict objectForKey:@"title"];
//             
//             NSLog(@"Title: %@", moviesString);
//             NSLog(@"%@", moviesDict);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

@end

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

+ (void)getTitles:(NSDictionary *)titles
      andSubjects:(NSArray *)subjects
       completion:(void(^)(NSArray *data))completion
{
    NSString *urlString = @"https://heads-up-api.herokuapp.com/";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // NEED TO LOOP THROUGH THE ARRAY...
             
             
             //             NSLog(@"%@", responseObject);
            
             //             for (titleString in responseObject) {
             //                 NSLog(@"The title is: %@", titleString);
             //             }
             NSDictionary *superStars = [responseObject objectAtIndex:0];
             NSString *title = [superStars objectForKey:@"title"];
             NSLog(@"PLEASE: %@", title);
            

//             NSLog(@"title is: %@", superStars);
             
             //             for (subjectsArray in responseObject) {
             //                 NSLog(@"The subjects are: %@", subjectsArray);
             //             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

//NSDictionary *response = [responseObject objectForKey:@"response"];
//NSArray *venues = [response objectForKey:@"venues"];


@end

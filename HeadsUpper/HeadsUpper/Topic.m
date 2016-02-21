//
//  Topic.m
//  HeadsUpper
//
//  Created by Justine Gartner on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "Topic.h"

@implementation Topic

-(instancetype)initWithJSON: (NSDictionary *)json{
    
    if (self = [super init]){
        
        self.title = json[@"title"];
        self.answers = json[@"subjects"];
        
        return self;
        
    }
    return nil;
    
}

@end

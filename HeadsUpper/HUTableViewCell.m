//
//  HUTableViewCell.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTableViewCell.h"

@implementation HUTableViewCell

- (instancetype)initWithCategory:(HUCategory)category{

    if (self = [super init]){
        self.category = category;
        return self;
    }

    return nil;
}



@end

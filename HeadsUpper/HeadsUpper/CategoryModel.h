//
//  CategoryModel.h
//  HeadsUpper
//
//  Created by Xiulan Shi on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic) NSMutableArray *categories;

+ (instancetype)sharedInstance;

- (void)initializeModel;

@end

//
//  CategoryAndClueSetup.h
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUGameCategory.h"


@interface CategoryAndClueSetup : NSObject


@property (nonatomic) NSMutableArray<HUGameCategory *> *gameCategories;

-(instancetype)initCategories;


@end

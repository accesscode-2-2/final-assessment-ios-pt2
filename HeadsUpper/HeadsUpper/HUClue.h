//
//  HUClue.h
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HUGameCategory;


@interface HUClue : NSObject

@property (nonatomic) NSString *description;
@property (nonatomic) HUGameCategory *category;

@end

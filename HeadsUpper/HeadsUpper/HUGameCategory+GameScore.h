//
//  HUGameCategory+GameScore.h
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameCategory.h"

@interface HUGameCategory (GameScore)

+(NSString *)getreportForScore:(NSInteger)score andCategory:(HUGameCategory *)category;


@end

//
//  ViewController.h
//  HeadsUpper
//
//  Created by Michael Kavouras on 2/17/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameData.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic)NSString *category;
@property (strong, nonatomic)GameData *data;
@property (nonatomic) NSUInteger correct;
@property (nonatomic) NSUInteger incorrect;

-(void) randomClue;

@end


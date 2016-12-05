//
//  GuessViewController.h
//  HeadsUpper
//
//  Created by Bereket  on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessViewController : UIViewController

@property (nonatomic) NSInteger timeCount;

@property (nonatomic) UIAlertView* GameOverAlertView;

@property (nonatomic) NSMutableArray* answersArray;




@end

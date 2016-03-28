//
//  HUGameScreenViewController.h
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUGameScreenViewController : UIViewController

@property (nonatomic) NSDictionary *selectedGameSubject;

+ (instancetype)shuffledArr:(NSArray *)firstArr;

@end

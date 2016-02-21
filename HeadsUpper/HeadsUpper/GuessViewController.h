//
//  GuessViewController.h
//  HeadsUpper
//
//  Created by Jason Wang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    DidReset1,
    DidReset0
} ResetStat;

@interface GuessViewController : UIViewController

@property (nonatomic) NSMutableArray *guessTerms;
@property (nonatomic) NSString *category;

@end

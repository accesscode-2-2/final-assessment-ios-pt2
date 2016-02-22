//
//  TitlesTableViewController.h
//  HeadsUpper
//
//  Created by Brian Blanco on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TitlesTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *topics;
@property (strong, nonatomic) NSMutableArray *subjects;
@property (strong, nonatomic) NSMutableDictionary *allStuff;

@end

//
//  HUGameViewController.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameViewController.h"

@interface HUGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;

@end

@implementation HUGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clueLabel.text =self.category.clues[0];
}



@end

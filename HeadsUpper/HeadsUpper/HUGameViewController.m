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

@property (nonatomic) NSInteger *gameScore;

@end

@implementation HUGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clueLabel.text =self.category.clues[0];
    [self setupSwipeGestures];
}

- (void)setupSwipeGestures {
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRight];
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gesture {
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gesture {
    self.view.backgroundColor = [UIColor greenColor];
}

@end

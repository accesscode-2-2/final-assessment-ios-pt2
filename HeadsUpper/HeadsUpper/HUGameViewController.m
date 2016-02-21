//
//  HUGameViewController.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameViewController.h"
#import "HUGameCategory+GameScore.h"

@interface HUGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger gameScore;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger timerCount;

@end

@implementation HUGameViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupSwipeGestures];
    [self setupTimer];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.gameScore = 0;
    self.currentIndex = 0;
    self.timerCount = 0;
}

#pragma mark - setup

- (void)setup {
    self.navigationItem.title = @"Let's Play!";
    self.gameScore = 0;
    self.currentIndex = 0;
    self.timerCount = 0;
    self.clueLabel.text =self.category.clues[self.currentIndex];
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

#pragma mark - Handle Timer 

- (void)timerFired:(NSTimer *)timer {
    self.timerCount++;
    self.timerLabel.text = [NSString stringWithFormat:@"0:%d",30-self.timerCount];
    
    if (self.timerCount == 30) {
        [timer invalidate];
    }
}

#pragma mark - Label Helper Method

-(void)setupNextClue {
    self.currentIndex+=1;
    self.clueLabel.text = self.category.clues[self.currentIndex];
}

#pragma mark - Swipes

- (void)setupSwipeGestures {
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRight];
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gesture {
    if (self.currentIndex < self.category.clues.count-1) {
        [self setupNextClue];
        self.view.backgroundColor = [UIColor orangeColor];
    }
    else {
        [self showAlert];
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gesture {
    if (self.currentIndex < self.category.clues.count-1) {
        self.view.backgroundColor = [UIColor greenColor];
        [self setupNextClue];
        self.gameScore+=1;
    }
    else {
        [self showAlert];
    }
}

#pragma mark - Alert

-(void)showAlert {
    NSString *score = [HUGameCategory getreportForScore:self.gameScore andCategory:self.category];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:[NSString stringWithFormat:@"You got: %@",score] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end

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

@property (nonatomic) UISwipeGestureRecognizer *leftGesture;
@property (nonatomic) UISwipeGestureRecognizer *rightGesture;

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
    
    if (self.timerCount > 20) {
        self.timerLabel.text = [NSString stringWithFormat:@"0:0%d",30-self.timerCount];
    }else{
        self.timerLabel.text = [NSString stringWithFormat:@"0:%d",30-self.timerCount];
    }
    
    if (self.timerCount >= 30) {
        [timer invalidate];
        [self showAlert];
    }
}

#pragma mark - Swipes

- (void)setupSwipeGestures {
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeft];
    
    self.leftGesture = swipeLeft;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRight];
    
    self.rightGesture = swipeRight;
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gesture {
    
    if (self.currentIndex < self.category.clues.count-1) {
        [self setupNextClue];
        self.view.backgroundColor = [UIColor orangeColor];
        [self tempTimer];
    }
    else {
        [self showAlert];
        self.timerCount = 29;
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gesture {
    
    if (self.currentIndex < self.category.clues.count-1) {
        self.view.backgroundColor = [UIColor greenColor];
        [self tempTimer];
        [self setupNextClue];
        self.gameScore+=1;
    }
    else {
        self.gameScore+=1;
        [self showAlert];
        self.timerCount = 29;
    }
}

-(void)removeGesture {
    [self.view removeGestureRecognizer:self.leftGesture];
    [self.view removeGestureRecognizer:self.rightGesture];
}

#pragma Temp Timer

-(void)tempTimer {
    
   NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(handleTempTimer:)
                                   userInfo:nil
                                    repeats:NO];
    
   // NSTimer *timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(tempTimerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

-(void)handleTempTimer:(NSTimer *)timer {
//    if (self.view.backgroundColor != [UIColor whiteColor]){
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
}

#pragma mark - Label Helper Method

-(void)setupNextClue {
    self.currentIndex+=1;
    self.clueLabel.text = self.category.clues[self.currentIndex];
}


#pragma mark - Alert

-(void)showAlert {
    NSString *score = [HUGameCategory getreportForScore:self.gameScore andCategory:self.category];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over" message:[NSString stringWithFormat:@"You got: %@. Play another category!",score] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    
    [self removeGesture];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end

//
//  HUGameViewController.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameViewController.h"
#import "HUGameCategory+GameScore.h"
#import <CoreMotion/CoreMotion.h>

@interface HUGameViewController () <UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger gameScore;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic) UISwipeGestureRecognizer *leftGesture;
@property (nonatomic) UISwipeGestureRecognizer *rightGesture;
@property (nonatomic) NSTimer *timer;
@property (nonatomic,strong) CMMotionManager *motionManager;
@property (nonatomic) BOOL isTilted;

@end

@implementation HUGameViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
    [self setupSwipeGestures];
    [self setupTimer];
    [self setupAccelerometer];
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
    self.timer = timer;
    [timer fire];
}

- (void)setupAccelerometer {
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 1.0f/60.0f;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"Error, no data for acceleroeter :%@",[error localizedDescription]);
                                                 }
                                             }];
}

#pragma mark - Handle Timer

- (void)timerFired:(NSTimer *)timer {
    
    self.timerCount++;
    
    if (self.timerCount > 20) {
        self.timerLabel.text = [NSString stringWithFormat:@"0:0%d",30-self.timerCount];
    }
    else {
        self.timerLabel.text = [NSString stringWithFormat:@"0:%d",30-self.timerCount];
    }
    if (self.timerCount >= 30) {
        [timer invalidate];
        [self showAlert];
    }
}

#pragma mark - Accelerometer

- (void) outputAccelerationData:(CMAcceleration)acceleration{
    
    if(self.timer){
        
        if (!self.isTilted) {
            if (acceleration.x > 0.4f) {
                self.isTilted = YES;
                [self correctAnswer];
            }
            else if (acceleration.x < -0.4f) {
                self.isTilted = YES;
                [self skip];
            }
        }
        else {
            if (acceleration.x < 0.2f && acceleration.x > -0.2f) {
                self.isTilted = NO;
            }
        }
    }
}

- (void)correctAnswer {
    
    if (self.currentIndex < self.category.clues.count-1) {
        
        [self animateWithColor:[UIColor greenColor]];
        [self setupNextClue];
        self.gameScore+=1;
    }
    
    else {
        self.gameScore+=1;
        [self showAlert];
        [self.timer invalidate];
    }
    
}

- (void)skip {
    
    if (self.currentIndex < self.category.clues.count-1) {
        [self animateWithColor:[UIColor orangeColor]];
        [self setupNextClue];
    }
    else {
        [self showAlert];
        [self.timer invalidate];
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
        [self animateWithColor:[UIColor orangeColor]];
        [self setupNextClue];
    }
    else {
        [self showAlert];
        [self.timer invalidate];
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gesture {
    
    if (self.currentIndex < self.category.clues.count-1) {
        
        [self animateWithColor:[UIColor greenColor]];
        [self setupNextClue];
        self.gameScore+=1;
    }
    else {
        self.gameScore+=1;
        [self showAlert];
        [self.timer invalidate];
    }
}

-(void)removeGesture {
    [self.view removeGestureRecognizer:self.leftGesture];
    [self.view removeGestureRecognizer:self.rightGesture];
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
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self removeGesture];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Animation Helper

-(void)animateWithColor:(UIColor *)color {
    
    [UIView animateWithDuration:0.5 delay:0.09 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.backgroundColor = color;
    } completion:^(BOOL finished) {
        self.view.backgroundColor = [UIColor whiteColor];
    }];
}

@end

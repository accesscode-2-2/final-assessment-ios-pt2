//
//  GuessViewController.m
//  HeadsUpper
//
//  Created by Jason Wang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GuessViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface GuessViewController () <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessTerm;
@property (nonatomic) NSInteger numberOfCorrectGuess;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger atIndex;
@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) NSTimer *motionTimer;
//@property (nonatomic) BOOL didResetStat;
@property (nonatomic) ResetStat resetState;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButton;

@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfCorrectGuess = 0;
    self.atIndex = 0;
    self.guessTerm.text = [self.guessTerms objectAtIndex:self.atIndex];
    self.timeLeftLabel.text = @"10";
    self.motionManager = [[CMMotionManager alloc]init];
//    self.didResetStat = YES;
    self.resetState = DidReset1;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self alertViewWithTitle:[NSString stringWithFormat:@"Category: %@",self.category] andMsg:@"You have 10 sec to guess"];
}
- (IBAction)backButtonTapped:(UIBarButtonItem *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
    [self.motionTimer invalidate];
}

- (void)alertViewWithTitle:(NSString*)title andMsg:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (self.timerCount < 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self setupTimer];
            [self setupMotionUpdate];
        }
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setupMotionUpdate {
    self.motionManager.deviceMotionUpdateInterval = 0.30;
    [self.motionManager startDeviceMotionUpdates];
    self.motionTimer = [NSTimer timerWithTimeInterval:0.30 target:self selector:@selector(deviceMoved) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.motionTimer forMode:NSRunLoopCommonModes];
    [self.motionTimer fire];
}
-(void)setupTimer{
    self.atIndex = 0;
    //timer after 1 second
    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    //create timer, add it to a run loop. Done!
    
    self.timerCount = 100;
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

-(void)timerFired:(NSTimer *)timer{
    NSString *convertedString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.timeLeftLabel.text = convertedString;
    self.timerCount --;
    if (self.timerCount < 0) {
        [timer invalidate];
        [self.motionTimer invalidate];
        [self alertViewWithTitle:@"Times up" andMsg:[NSString stringWithFormat:@"Your total score is %ld", self.numberOfCorrectGuess]];
    }
}

- (void)alertViewResultScore {
    
}

- (void)deviceMoved {
    double roll = self.motionManager.deviceMotion.attitude.roll;
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"roll = %0.2f",roll);
    if (roll > 2.5) {
        if (self.resetState == DidReset1) {
//            self.didResetStat = NO;
            self.resetState = DidReset0;
            self.view.backgroundColor = [UIColor greenColor];
            self.numberOfCorrectGuess += 1;
            [self updateLabel: roll];
            self.atIndex ++;
            NSLog(@"guess term changed");
        }
        
    } else if (roll < -0.001){
        if (self.resetState == DidReset1) {
//            self.didResetStat = NO;
            self.resetState = DidReset0;
            self.view.backgroundColor = [UIColor redColor];
            [self updateLabel:roll];
            self.atIndex ++;
            NSLog(@"guess term changed");
        }
    } else {
        [self updateLabel:roll];
    }
}

- (void)updateLabel: (double) roll{
    if (self.atIndex < self.guessTerms.count - 1) {
        self.guessTerm.text = [self.guessTerms objectAtIndex:self.atIndex];
        NSLog(@"numberOfCorrectGuess = %ld",self.numberOfCorrectGuess);
        
        if (roll < 2.0 && roll > 1.01) {
//            self.didResetStat = YES;
            self.resetState = DidReset1;
        } else {
//            self.didResetStat = NO;
            self.resetState = DidReset0;
        }
//        NSLog(@"didResetStat %d",self.didResetStat);
    } else {
//        self.atIndex = 0;
        NSLog(@"end of index");
    }
}


@end

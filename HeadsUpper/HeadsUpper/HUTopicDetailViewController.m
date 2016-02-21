//
//  HUTopicDetailViewController.m
//  HeadsUpper
//
//  Created by Eric Sze on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTopicDetailViewController.h"
#import "HUTableViewController.h"

@interface HUTopicDetailViewController ()

@property (nonatomic, assign) NSInteger timerCount;

@property (nonatomic, assign) NSInteger totalSwipes;
@property (nonatomic, assign) NSInteger rightSwipes;

@property (nonatomic, strong) NSMutableArray *answerHasAppeared;

@end

@implementation HUTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupTimer];
    [self randomAnswer];
    [self setUpGestureRecognizers];
}

- (void)setup {
    self.navigationItem.title = self.topicTitle;
    
    self.totalSwipes = 1;
    self.rightSwipes = 0;
    self.countdownTimerLabel.text = @"10";
    
    self.answerHasAppeared = [[NSMutableArray alloc] initWithArray:self.topicAnswers copyItems:YES];
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 9;
}

- (void)timerFired:(NSTimer *)timer {
    switch (self.timerCount) {
        case 5:
            self.countdownTimerLabel.textColor = [UIColor orangeColor];
            break;
        case 3:
            self.countdownTimerLabel.textColor = [UIColor redColor];
            break;
        case 0:
            [timer invalidate];
            [self gameOver];
            self.view.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
    self.countdownTimerLabel.text = @"10";
    NSString *timeLeft = [NSString stringWithFormat: @"%ld", (long)self.timerCount];
    self.countdownTimerLabel.text = timeLeft;

    self.timerCount--;
}

- (void)gameOver {
    NSString *message = [NSString stringWithFormat:@"%ld/%ld", (long)self.rightSwipes, (long)self.totalSwipes];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over!"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"Done"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]; //You can use a block here to handle a press on this button
    [alertController addAction:actionDone];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setUpGestureRecognizers {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *) gesture {
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self backgroundGlowAnimationFromColor:[UIColor orangeColor] toColor:[UIColor whiteColor] clearAnimationsFirst:YES];
            [self randomAnswer];
            self.totalSwipes++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self backgroundGlowAnimationFromColor:[UIColor greenColor] toColor:[UIColor whiteColor] clearAnimationsFirst:YES];
            [self randomAnswer];
            self.totalSwipes++;
            self.rightSwipes++;
            break;
        default:
            return;
    }
}

- (void)randomAnswer {
    //    if (self.answerHasAppeared == nil) {
    //        [self gameOver];
    //    }
    NSUInteger n = self.answerHasAppeared.count;
    NSUInteger currRandIdx = arc4random_uniform((u_int32_t)n);
    self.topicAnswerTextLabel.text = self.answerHasAppeared[currRandIdx];
    [self.answerHasAppeared removeObject:self.answerHasAppeared[currRandIdx]];
    
    NSLog(@"%@", self.answerHasAppeared);
}

#pragma mark - Background Glow | Pass - Orange:White / Correct - Green:White
- (void)backgroundGlowAnimationFromColor:(UIColor *)startColor toColor:(UIColor *)destColor clearAnimationsFirst:(BOOL)reset {
    if (reset) {
        [self.view.layer removeAllAnimations];
    }
    
    CABasicAnimation *anAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anAnimation.duration = 1.00;
    anAnimation.repeatCount = 0;
    anAnimation.autoreverses = NO;
    anAnimation.fromValue = (id) startColor.CGColor; // [NSNumber numberWithFloat:1.0];
    anAnimation.toValue = (id) destColor.CGColor; //[NSNumber numberWithFloat:0.10];
    [self.view.layer addAnimation:anAnimation forKey:@"backgroundColor"];
}

@end

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

@end

@implementation HUTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.topicTitle;

    [self setupTimer];
    [self randomAnswer];
    [self setUpGestureRecognizers];
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 9;
}

- (void)timerFired:(NSTimer *)timer {
    if (self.timerCount == 0) {
        self.countdownTimerLabel.text = nil;
        [timer invalidate];
        [self gameOver]; //Title: @"Done"
        //        self.timerCount = 10;
    }
    
    self.countdownTimerLabel.text = @"10";
    NSString *timeLeft = [NSString stringWithFormat: @"%ld", (long)self.timerCount];
    self.countdownTimerLabel.text = timeLeft;
    
    self.timerCount--;
}

- (void)gameOver {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over!"
                                                                             message:@"# right/total # of questions swiped"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //We add buttons to the alert controller by creating UIAlertActions:
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
            self.view.backgroundColor = [UIColor darkGrayColor];
            [self randomAnswer];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor orangeColor];
            [self randomAnswer];
            break;
        default:
            return;
    }
}

- (void)randomAnswer {
    NSUInteger n = self.topicAnswers.count;
    NSUInteger randIdx = arc4random_uniform((uint32_t)n);
    self.topicAnswerTextLabel.text = self.topicAnswers[randIdx];

    NSLog(@"%lu", (unsigned long)n);
    NSLog(@"%@", self.topicAnswers[randIdx]);
    NSLog(@"%@", self.topicAnswers);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

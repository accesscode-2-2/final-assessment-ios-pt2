//
//  HUGameScreenViewController.m
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameScreenViewController.h"
#import "HUTopicsTableViewController.h"

@interface HUGameScreenViewController ()
<
UIAlertViewDelegate
>

@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger gameClueCount;
@property (nonatomic) NSInteger pointsCount;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (nonatomic) NSArray *subjects;

@property (nonatomic) UIView *gameVC;

@end

@implementation HUGameScreenViewController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestureRecognizer];
    self.navigationItem.title = self.selectedGameSubject[@"title"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.clueLabel.text = self.selectedGameSubject[@"subjects"][self.gameClueCount];
    [self gameStart];
}

#pragma mark - Game Implementation

- (void)gameStart
{
    [self setUpTimer];
    self.gameClueCount = 0;
    self.pointsCount = 0;
}

#pragma mark - Timer Implementation

- (void)setUpTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    [timer fire];
}

- (void)timerFired:(NSTimer *)timer
{
    if (self.timerCount == 0) {
        [timer invalidate];
        [self showGameOverAlert];
    }
    
    NSString *intToString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.timerLabel.text = intToString;
    self.timerCount--;
}

#pragma mark - Swipe Implementation

- (void)setupGestureRecognizer
{
    UISwipeGestureRecognizer *wrongAnswerSwipe = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget: self
                                                  action: @selector(handleSwipe:)];
    
    wrongAnswerSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:wrongAnswerSwipe];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    if (self.timerCount != 0) {
        self.gameClueCount++;
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
                
                [self revertViewToWhiteAfterAnswer:[UIColor redColor]];
                
                self.clueLabel.text = self.selectedGameSubject[@"subjects"][self.gameClueCount];
                break;
            default:
                break;
        }
    }
    
    // app crashes if you go out of bounds, trying to fix that but it
    // seems like an edge case so won't worry about it now
    //    if (self.subjects.count == 32) {
    //        return;
    //    }
}

- (void)revertViewToWhiteAfterAnswer:(UIColor *)color
{
    [UIView animateWithDuration:0 animations:^{
        self.view.backgroundColor = [UIColor redColor];
    }];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)turnViewGreenIfRight:(UIColor *)color
{
    [UIView animateWithDuration:0 animations:^{
        self.view.backgroundColor = [UIColor greenColor];
    }];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
}

#pragma mark - Motion Shake Implementation

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (self.timerCount != 0) {
        self.gameClueCount++;
        self.clueLabel.text = self.selectedGameSubject[@"subjects"][self.gameClueCount];
    }
    if (motion == UIEventSubtypeMotionShake) {
        self.pointsCount++;
        [self turnViewGreenIfRight:[UIColor greenColor]];
    }
}

#pragma mark - Alerts Implementation

- (void)showGameOverAlert
{
    NSString *pointsMessage = [NSString stringWithFormat:@"Game Over! You got %ld/%ld right", (long)self.pointsCount,(long)self.gameClueCount];
    
    for (UIGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"HeadsUpper™"
                              message:pointsMessage
                              delegate:self
                              cancelButtonTitle:@"Play Again"
                              otherButtonTitles:@"Close", nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.clueLabel.text = self.selectedGameSubject[@"subjects"][self.gameClueCount];
        [self gameStart];
        [self setupGestureRecognizer];

    }
    if (buttonIndex == 1)
    {
        
    }
}

// couldn't get shuffle to work :(

//+ (instancetype)shuffledArr:(NSArray *)firstArr
//{
//    NSMutableArray *shuffledArr = [NSMutableArray arrayWithArray:firstArr];
//    
//    for (int i = 0; i < shuffledArr.count; i++) {
//        int j = arc4random_uniform((int)shuffledArr.count);
//        id tempIndex = shuffledArr[j];
//        [shuffledArr replaceObjectAtIndex:j withObject:shuffledArr[i]];
//        [shuffledArr replaceObjectAtIndex:i withObject:tempIndex];
//    }
//    return (NSArray *)shuffledArr;
//}

@end

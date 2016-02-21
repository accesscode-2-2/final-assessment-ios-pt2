//
//  GameTimeViewController.m
//  HeadsUpper
//
//  Created by Shena Yoshida on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTimeViewController.h"
#import "GameModel.h"

@interface GameTimeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger questionCount;
@property (nonatomic) NSInteger score;

@end

@implementation GameTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.topicLabel.text = [self.category.items objectAtIndex:0];
    
    self.score = 0;
    
    [self setupTimer];
    [self setupGestureRecognizers];
    
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    
    [timer fire]; // start timer
}

- (void)timerFired:(NSTimer *)timer {
    
     NSString *time = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    
    if (self.timerCount < 1) {
        [timer invalidate];
        
        // here's where we will bump to next question
        [self advanceQuestion];
        
        // reset timer and label:
        self.timerCount = 0;
        self.timerLabel.text = time;
    }
    
    self.timerCount --;
    self.timerLabel.text = time;
}

- (void)setupGestureRecognizers {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(advanceQuestion)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(advanceQuestion)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];

}

- (void)advanceQuestion {
    self.questionCount ++;
    self.topicLabel.text = [self.category.items objectAtIndex:self.questionCount];
}







@end

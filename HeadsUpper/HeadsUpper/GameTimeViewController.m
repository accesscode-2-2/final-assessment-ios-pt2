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

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger questionCount;
@property (nonatomic) NSInteger score;

@end

@implementation GameTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.backgroundColor = [UIColor lightGrayColor].CGColor;

    self.navigationController.navigationBar.topItem.title = @"Menu";

    
    self.questionCount = 1;
    
    self.topicLabel.text = [self.category.items objectAtIndex:0];
   
    self.score = 0;
    
    [self setupTimer];
    [self setupGestureRecognizers];
    
}

- (void)setupTimer {
    
    self.questionCount ++;
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    
    [self.timer fire]; // start timer
}

- (void)timerFired:(NSTimer *)timer {
    
     NSString *time = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    
    if (self.timerCount == 0) {
        
        [self swipeLeft];
    }
    
    self.timerCount --;
    self.timerLabel.text = time;
}

- (void)setupGestureRecognizers {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];

}

// left = wrong
- (void)swipeLeft {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.layer.backgroundColor = [UIColor redColor].CGColor;
    } completion:nil];
    
    if (self.questionCount != self.category.items.count - 1) {
        
        [self.timer invalidate];
        [self setupTimer];
        
        self.topicLabel.text = [self.category.items objectAtIndex:self.questionCount];
   
    } else {
        self.view.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.timer invalidate];
        NSString *score = [[NSNumber numberWithInteger:self.score]stringValue];
        NSString *numberOfQuestions = [[NSNumber numberWithInteger:self.questionCount]stringValue];
        self.topicLabel.text = [NSString stringWithFormat:@"YOUR SCORE: \n%@/%@", score, numberOfQuestions];
        self.timerLabel.hidden = YES;
    }
}

// right = correct
- (void)swipeRight {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.layer.backgroundColor = [UIColor greenColor].CGColor;
    } completion:nil];

    if (self.questionCount != self.category.items.count - 1) {
    
    [self.timer invalidate];
    [self setupTimer];
        
    self.score ++;
    self.topicLabel.text = [self.category.items objectAtIndex:self.questionCount];
    NSLog(@"score: %ld", (long)self.score);
        
    } else {
    self.view.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.timer invalidate];
    NSString *score = [[NSNumber numberWithInteger:self.score]stringValue];
    NSString *numberOfQuestions = [[NSNumber numberWithInteger:self.questionCount]stringValue];
    self.topicLabel.text = [NSString stringWithFormat:@"YOUR SCORE: \n%@/%@", score, numberOfQuestions];
    self.timerLabel.hidden = YES;
    }
}






@end

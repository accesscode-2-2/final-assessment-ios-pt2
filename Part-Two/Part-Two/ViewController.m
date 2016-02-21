//
//  ViewController.m
//  Part-Two
//
//  Created by Fatima Zenine Villanueva on 2/20/16.
//  Copyright © 2016 Kaira. All rights reserved.
//

#import "ViewController.h"
#import "GameManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSDate *initialDate;

@property (weak, nonatomic) IBOutlet UILabel *answer;

@property (nonatomic) NSInteger totalGameTime;

@property (nonatomic) int index;

@property (nonatomic) int score;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) UIView *colorView;

@property (nonatomic) NSString *color;

@end

@implementation ViewController

- (void)createTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(timerFired:)
                                                    userInfo:nil
                                                     repeats: YES];
    
    [timer fire];
}

- (void)timerFired: (NSTimer *)timer {
    
    
    if (!self.initialDate) {
        
        self.initialDate = [NSDate date];
    }
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:self.initialDate];
    
    NSInteger seconds = secondsBetween;
    
    NSInteger countDown = self.totalGameTime - seconds;
    
    NSLog(@"%02lu", (long)countDown);
    
    self.timerLabel.text = [NSString stringWithFormat:@" %02lu ", (long)countDown];
    
    if (seconds >= self.totalGameTime || self.score == self.topicCards.count || self.index == self.topicCards.count - 1) {
        
        [timer invalidate];
        
        self.initialDate = nil;
        
        NSString *totalScore = [NSString stringWithFormat:@"%u / %u correct!", self.score, self.topicCards.count];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Guessing Game"
                                                                                 message:totalScore
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Done"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:^{}];
    }
    
}

- (void)setupGestureRecognizer {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget: self
                                           action: @selector(handleSwipe :)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget: self
                                            action: @selector(handleSwipe :)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void)handleSwipe: (UISwipeGestureRecognizer *)gesture {
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            self.color = @"Green";
            
            [self changeBackGroundColor];
            
            [self answerLabelChange];
            self.score++;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %u", self.score];

            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            
            self.color = @"Red";
            
            [self changeBackGroundColor];
            
            [self answerLabelChange];

            break;
            
        default:
            
            break;
    }
    
}

- (void)changeBackGroundColor {
    
    self.colorView = [[UIView alloc]initWithFrame:self.view.frame];
    
    if ([self.color isEqualToString:@"Green"]) {
        
        self.colorView.backgroundColor = [UIColor greenColor];

    }
    
    else if ([self.color isEqualToString:@"Red"]) {
        
        self.colorView.backgroundColor = [UIColor redColor];

    }
    
    [self.view addSubview:self.colorView];
    
    [UIView animateWithDuration:1 delay:0.3 options:0 animations:^{
        self.colorView.alpha = 0;
    } completion:^(BOOL finished)
     {
         [self.colorView removeFromSuperview];
     }];

    
}

- (void)answerLabelChange {
    
    if (self.index != self.topicCards.count - 1) {
        
        self.index++;
        
        self.answer.text = [self.topicCards objectAtIndex: self.index];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.totalGameTime = 10;
    
    self.index = 0;
    
    self.score = 0;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %u", self.score];
    
    self.answer.text = [self.topicCards objectAtIndex:self.index];

    [self setupGestureRecognizer];
    
    [self createTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

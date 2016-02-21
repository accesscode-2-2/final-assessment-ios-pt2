//
//  QuestionsViewController.m
//  HeadsUpper
//
//  Created by Elber Carneiro on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "QuestionsViewController.h"

@interface QuestionsViewController()

@property (nonatomic) NSInteger iterator;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger colorTimerCount;
@property (nonatomic) UIColor *flashColor;
@property (nonatomic) NSInteger numberCorrect;

@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSLog(@"%@", self.questions);
    
    [self shuffleQuestions];
    NSLog(@"%@", self.questions);
    
    self.iterator = 16;
    self.numberCorrect = 0;
    self.flashColor = [UIColor whiteColor];
    
    [self countdownTimer];
    [self setupGestureRecognizers];
}

- (void)shuffleQuestions {
    
    NSUInteger count = [self.questions count];
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self.questions exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (void)countdownTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timerCount = 5;
    [timer fire];
}

- (void)timerFired:(NSTimer *)timer {
    
    if (self.timerCount < 1) {
        
        self.questionLabel.font = [UIFont systemFontOfSize:22];
        self.questionLabel.text = self.questions[self.iterator];
        [timer invalidate];
        for (UISwipeGestureRecognizer *recognizer in self.view.gestureRecognizers) {
            
            if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft ||
                recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
                
                recognizer.enabled = YES;
            }
        }
        
    } else {
        
        self.questionLabel.font = [UIFont systemFontOfSize:36];
        NSString *convertedToString = [[NSNumber numberWithInteger:self.timerCount]stringValue];
        self.questionLabel.text = convertedToString;
        for (UISwipeGestureRecognizer *recognizer in self.view.gestureRecognizers) {
            
            if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft ||
                recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
                
                recognizer.enabled = NO;
            }
        }
    }
    self.timerCount--;
}

- (void)setupGestureRecognizers {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:downSwipe];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.flashColor = [UIColor redColor];
            [self colorSwipeHelper];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.flashColor = [UIColor greenColor];
            self.numberCorrect++;
            [self colorSwipeHelper];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            return;
    }
}

- (void)colorSwipeHelper {
    
    self.iterator++;
    if (self.iterator > self.questions.count - 1) {
        [self colorTimer];
        [self resultsPopup];
    } else {
        [self colorTimer];
        [self countdownTimer];
    }
}

- (void)colorTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.25 target:self selector:@selector(colorTimerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.colorTimerCount = 1;
    [timer fire];
}

- (void)colorTimerFired:(NSTimer *)timer {
    if (self.colorTimerCount < 1) {
        self.view.backgroundColor = [UIColor whiteColor];
        [timer invalidate];
    } else {
        self.view.backgroundColor = self.flashColor;
        self.colorTimerCount--;
    }
}

- (void)resultsPopup {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:[NSString stringWithFormat:@"%ld/%lu", (long)self.numberCorrect, (unsigned long)self.questions.count]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

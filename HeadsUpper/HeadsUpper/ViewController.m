//
//  ViewController.m
//  HeadsUpper
//
//  Created by Michael Kavouras on 2/17/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import <SIAlertView/SIAlertView.h>

@interface ViewController ()
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger readyTimerCount;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *guess;
@property (nonatomic) NSInteger rightCount;
@property (weak, nonatomic) IBOutlet UIView *readyView;
@property (weak, nonatomic) IBOutlet UILabel *readyLabel;

@property (nonatomic) NSInteger whichAnswerAreWeAt;
@property (nonatomic) NSInteger totalGuesses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whichAnswerAreWeAt = 0;
    self.rightCount = 0;
    self.totalGuesses = 1;
    self.guess.text = self.answers[self.whichAnswerAreWeAt];
    self.readyLabel.text = @"3";
    [self setupReadyTimer];
    self.readyView.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame: self.view.frame andColors:@[[UIColor flatWhiteColorDark], [UIColor flatWhiteColor]]];
    
}

# pragma mark - gesture methods
- (void) setUpGestureRecognizers {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction= UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void) handleSwipe: (UISwipeGestureRecognizer *) gesture {
    if (self.whichAnswerAreWeAt==self.answers.count-1) {
        self.whichAnswerAreWeAt = 0;
    }
    else{
        self.whichAnswerAreWeAt++;
    }
    
    switch (gesture.direction) {
        case  UISwipeGestureRecognizerDirectionRight:
            [self animateViewWith:[UIColor flatWatermelonColorDark]];

            self.totalGuesses++;
            self.guess.text = self.answers[self.whichAnswerAreWeAt];
            
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self animateViewWith:[UIColor flatMintColorDark]];
            self.rightCount++;
            self.totalGuesses++;
            self.guess.text = self.answers[self.whichAnswerAreWeAt];
            break;
        default:
            break;
    }
}

-(void) animateViewWith:(UIColor* )color{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.backgroundColor = color;
                     } completion:^(BOOL finished) {
                         self.view.backgroundColor = [UIColor whiteColor];
                     }];
}

# pragma mark - timer methods
-(void) setupReadyTimer
{
    self.readyTimerCount = 2;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleReadyTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void) handleReadyTimer: (NSTimer * ) timer {
    
    
    self.readyLabel.text = [NSString stringWithFormat: @"%ld", (long)self.readyTimerCount];
    self.readyTimerCount--;
    
    if (self.readyTimerCount < 0 ) {
        self.readyLabel.text = @"Go!";
        [UIView animateWithDuration:1.0
                         animations:^{
                             self.readyView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                         } completion:^(BOOL finished) {
                             self.readyView.hidden = YES;
                         }];
        
        [self setupTimer];
        [timer invalidate];
        //hide ready screen
    }
    
}

-(void) setupTimer
{
    self.timerCount = 30;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleGameTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //[timer fire];
    [self setUpGestureRecognizers];
}

- (void) handleGameTimer: (NSTimer * ) timer {
    
    
    self.timerLabel.text = [NSString stringWithFormat: @"%ld", (long)self.timerCount];
    self.timerCount--;
    
    if (self.timerCount < 0 ) {
        [timer invalidate];
        
        //show score
        NSString * endGameText = [NSString stringWithFormat:@"you got %ld out of %ld right", (long)self.rightCount, self.totalGuesses];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Game Over" andMessage:endGameText];
        
        [alertView addButtonWithTitle:@"Play Again"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alert) {
                                  
                              }];
        
        alertView.didDismissHandler = ^(SIAlertView *alertView) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        
        [alertView show];
        
        
        //end game
        
        //
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

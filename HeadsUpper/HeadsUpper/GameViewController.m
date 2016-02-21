//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Justine Kay on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"
#import "GameView.h"

@interface GameViewController ()

@property (nonatomic) GameView *gameView;

@property (nonatomic) NSInteger totalCorrect;
@property (nonatomic) NSInteger totalAnswers;

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger timeInSeconds;

@property (nonatomic) BOOL introTimerFinished;

@end

@implementation GameViewController

- (void)loadView
{
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"GameView" owner:self options:nil] firstObject];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    self.gameView = (GameView *)self.view;
    
    [self.gameView.mainMenuButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.introTimerFinished = NO;
    
    [self setUpGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setViewProperties];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.timeInSeconds = 5;
    self.gameView.introCountdownLabel.text = [[NSNumber numberWithInteger:self.timeInSeconds] stringValue];
    self.gameView.introCountdownLabel.alpha = 1.0;
    [self startTimer];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setViewProperties
{
    
    self.gameView.answerLabel.alpha = 0;
    self.gameView.correctPassLabel.alpha = 0;
    self.gameView.countdownLabel.hidden = YES;
    
}

-(void)setUpGestureRecognizers
{
    
    UISwipeGestureRecognizer *upSwipe =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *downSwipe =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:upSwipe];
    [self.view addGestureRecognizer:downSwipe];
    
    
}

-(void)handleSwipe: (UISwipeGestureRecognizer *)gesture
{
    NSString *newAnswer = [self peekAndPopAnswer];
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionUp:
            
            self.gameView.answerLabel.text = newAnswer;
            
            [self fadeInFadeOutCorrectPassLabel:@"CORRECT!"];
            
            self.totalAnswers ++;
            self.totalCorrect ++;
            
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            self.gameView.answerLabel.text = newAnswer;
            
            [self fadeInFadeOutCorrectPassLabel:@"PASS"];
            
            self.totalAnswers ++;
            
            break;
            
        default:
            
            return;
    }
    
}

-(NSString *)peekAndPopAnswer
{
    NSString *answer = self.topic.answers.lastObject;
    [self.topic.answers insertObject: self.topic.answers.lastObject atIndex:0];
    [self.topic.answers removeLastObject];

    return answer;
}

-(void)fadeInFadeOutCorrectPassLabel:(NSString *) message
{

    self.gameView.correctPassLabel.text = message;
    
    [self.gameView.answerLabel setAlpha:0.0f];
    [self.gameView.correctPassLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.50f animations:^{
        
        [self.gameView.correctPassLabel setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
       [self.gameView.answerLabel setAlpha:1.0f];
         
            
        }];
}


#pragma mark - Timers

-(void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    
}


- (void)fireTimer: (NSTimer *) timer
{
    self.timeInSeconds -= 1;
    self.gameView.introCountdownLabel.text = [[NSNumber numberWithInteger:self.timeInSeconds] stringValue];
    
    if (self.timeInSeconds < 0) {
        
        self.gameView.introCountdownLabel.alpha = 0.0;
        self.gameView.answerLabel.alpha = 1.0;
        self.gameView.answerLabel.text = self.topic.answers.firstObject;
        
        [self resetTimer:timer];
        
        if (!self.introTimerFinished) {
            
            [self startTimer];
            self.introTimerFinished = YES;
        
        }else {
            
            self.gameView.answerLabel.alpha = 0.0;
            self.gameView.introCountdownLabel.text = @"Time's up!";
            self.gameView.introCountdownLabel.alpha = 1.0;
            
        }
        
    }
    
    NSLog(@"Timer Fired, time in seconds: %ld", (long)self.timeInSeconds);
}


- (void)resetTimer: (NSTimer *)timer
{
    if (self.timer){
        
        [self.timer invalidate];
        
        self.timeInSeconds = 30;
        
    }
}

@end

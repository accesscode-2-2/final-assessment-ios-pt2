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

@property (nonatomic) NSTimer *introTimer;
@property (nonatomic) NSTimer *gameTimer;

@property (nonatomic) NSInteger introTimeInSeconds;
@property (nonatomic) NSInteger gameTimeInSeconds;

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
    
    self.gameTimeInSeconds = 30;
    self.introTimeInSeconds = 5;
    self.gameView.answerLabel.text = [[NSNumber numberWithInteger:self.introTimeInSeconds] stringValue];
    
    [self setUpGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setViewProperties];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self startIntroTimer];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setViewProperties
{
    //self.gameView.answerLabel.alpha = 0;
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

-(void)startIntroTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireIntroTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.introTimer = timer;
    
}

-(void)startGameTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireIntroTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.gameTimer = timer;
    
}

- (void)fireIntroTimer: (NSTimer *) timer
{
    self.introTimeInSeconds -= 1;
    
    if (self.introTimeInSeconds < 0) {
        
        self.gameView.answerLabel.text = self.topic.answers.firstObject;
        
        [self resetIntroTimer:timer];
        
        [self startGameTimer];
    }
    
    NSLog(@"Intro Timer Fired, time in seconds: %ld", (long)self.introTimeInSeconds);
}

- (void) fireGameTimer: (NSTimer *) timer
{
    self.gameTimeInSeconds -= 1;
    
    if (self.gameTimeInSeconds == 0) {
        
        self.gameView.answerLabel.text = @"Time's up!";
        
        [self resetGameTimer:timer];
    }
    NSLog(@"Game Timer Fired, time in seconds: %ld", (long)self.gameTimeInSeconds);
}

- (void)resetIntroTimer: (NSTimer *)timer
{
    if (self.introTimer){
        
        [self.introTimer invalidate];
        
        self.introTimeInSeconds = 5;
        
    }
}

- (void)resetGameTimer: (NSTimer *)timer
{
    
    if (self.gameTimer) {
        
        [self.gameTimer invalidate];
        
        self.gameTimeInSeconds = 30;
    }

}


@end

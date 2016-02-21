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

@property (nonatomic) NSInteger timeInSeconds;

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
    
    [((GameView *)self.view).mainMenuButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setViewProperties];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setViewProperties
{
    GameView *view = (GameView *)self.view;
    
    view.answerLabel.alpha = 0;
    view.correctPassLabel.alpha = 0;
    view.countdownLabel.hidden = YES;
    
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
 
    GameView *view = (GameView *)self.view;
    NSString *newAnswer = [self peekAndPopAnswer];
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionUp:
            
            view.answerLabel.text = newAnswer;
            
            [self fadeInFadeOutCorrectPassLabel:@"CORRECT!"];
            
            self.totalAnswers ++;
            self.totalCorrect ++;
            
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            view.answerLabel.text = newAnswer;
            
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

-(void)fadeInFadeOutCorrectPassLabel:(NSString *) message{
    
    GameView *view = (GameView *)self.view;
    
    view.correctPassLabel.text = message;
    
    [view.answerLabel setAlpha:0.0f];
    [view.correctPassLabel setAlpha:1.0f];
    
    [UIView animateWithDuration:1.50f animations:^{
        
        [view.correctPassLabel setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
       [view.answerLabel setAlpha:1.0f];
         
            
        }];
}


#pragma mark - Timer

-(void)startIntroTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireIntroTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.introTimer = timer;
    self.timeInSeconds = 3;
    
}

-(void)fireIntroTimer: (NSTimer *) timer
{
    self.timeInSeconds -= 1;
    
    if (timer == self.introTimer && self.timeInSeconds == 0) {
        
        NSString *answer = [self peekAndPopAnswer];
        
    }
    
    NSLog(@"Timer Fired, time in seconds: %ld", (long)self.timeInSeconds);
}

-(void)resetTimer: (NSTimer *)timer
{
    if (timer == self.introTimer){
        
        [self.introTimer invalidate];
        
        self.timeInSeconds = 0;
    
    }else if (timer == self.gameTimer) {
        
        [self.gameTimer invalidate];
        
        self.timeInSeconds = 0;
    }
}


@end

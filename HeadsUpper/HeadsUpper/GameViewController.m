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
    [self.gameView.chooseNewTopicButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.gameView.playAgainButton addTarget:self action:@selector(playAgain) forControlEvents:UIControlEventTouchUpInside];
    
    self.introTimerFinished = NO;
    self.timeInSeconds = 5;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setViewProperties];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    self.gameView.introCountdownLabel.alpha = 1.0;
    [self startTimer];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.timer invalidate];
}

- (void)playAgain
{
    self.introTimerFinished = NO;
    self.timeInSeconds = 5;
    [self setViewProperties];
    self.gameView.introCountdownLabel.alpha = 1.0;
    [self startTimer];
}

- (void)setViewProperties
{
    self.gameView.mainMenuButton.hidden = NO;
    
    self.gameView.answerLabel.alpha = 0.0;
    self.gameView.correctPassLabel.alpha = 0.0;
    self.gameView.scoreLabel.alpha = 0.0;
    self.gameView.countdownLabel.hidden = YES;
    
    self.gameView.playAgainButton.hidden = YES;
    self.gameView.chooseNewTopicButton.hidden = YES;
    
    self.gameView.introCountdownLabel.alpha = 0.0;
    self.gameView.introCountdownLabel.text = [[NSNumber numberWithInteger:self.timeInSeconds] stringValue];
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

- (void)removeGestureRecognizers
{
    for (UISwipeGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:gesture];
    }
    
}


-(void)handleSwipe: (UISwipeGestureRecognizer *)gesture
{
    NSString *newAnswer = [self peekAndPopAnswer];
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionUp:
            
            self.gameView.answerLabel.text = newAnswer;
            
            [self fadeLabel:self.gameView.correctPassLabel WithMessage:@"CORRECT!"];
            
            self.totalAnswers ++;
            self.totalCorrect ++;
            
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            self.gameView.answerLabel.text = newAnswer;
            
            [self fadeLabel:self.gameView.correctPassLabel WithMessage:@"PASS"];
            
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

-(void)fadeLabel:(UILabel *)label WithMessage:(NSString *) message
{
    
    if (label == self.gameView.correctPassLabel) {
        
        label.text = message;
        
        self.gameView.answerLabel.alpha = 0.0;
        label.alpha = 1.0;
        
        [UIView animateWithDuration:1.50f animations:^{
            
            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            self.gameView.answerLabel.alpha = 1.0;
            
            
        }];

    } else {
        
        
        label.text = message;
        
        self.gameView.answerLabel.alpha = 0.0;
        label.alpha = 1.0;
        
        [UIView animateWithDuration:1.50f animations:^{
            
            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            self.gameView.scoreLabel.text = [NSString stringWithFormat: @"%ld out of %ld correct!", (long)self.totalCorrect, (long)self.totalAnswers];
            self.gameView.scoreLabel.alpha = 1.0;
            
            self.gameView.mainMenuButton.hidden = YES;
            self.gameView.playAgainButton.hidden = NO;
            self.gameView.chooseNewTopicButton.hidden = NO;
            
        }];

        
    }
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
    
    if (self.timeInSeconds <= 0) {
        
        self.gameView.introCountdownLabel.alpha = 0.0;
        self.gameView.answerLabel.alpha = 1.0;
        self.gameView.answerLabel.text = self.topic.answers.firstObject;
        
        [self resetTimer:timer];
        
        if (!self.introTimerFinished) {
            
            [self setUpGestureRecognizers];
            [self startTimer];
            self.introTimerFinished = YES;
        
        }else {
            
            [self fadeLabel:self.gameView.introCountdownLabel WithMessage:@"Time!"];
            [self removeGestureRecognizers];
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

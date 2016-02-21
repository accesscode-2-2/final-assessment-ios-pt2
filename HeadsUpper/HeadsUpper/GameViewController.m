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

@property (nonatomic) NSInteger totalCorrect;
@property (nonatomic) NSInteger totalAnswers;

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
    
    view.answerLabel.text = @"Guess This";
    view.correctPassLabel.hidden = YES;
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
            self.totalAnswers ++;
            self.totalCorrect ++;
            
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            view.answerLabel.text = newAnswer;
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

@end

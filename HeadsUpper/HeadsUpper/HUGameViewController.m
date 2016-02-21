//
//  HUGameViewController.m
//  HeadsUpper
//
//  Created by Felicia Weathers on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameViewController.h"
#import "HUTableViewController.h"


@interface HUGameViewController ()

@property (nonatomic, assign) NSInteger timerCount;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *cluesLabel;

@property (nonatomic, assign) NSInteger correctGuess;
@property (nonatomic, assign) NSInteger cluesCount;
@property (nonatomic, assign) NSInteger skippedClues;
@property (nonatomic, assign) NSString *playerScore;

- (void)shuffled;

@end

@implementation HUGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:1 alpha:1];
    
    [self shuffled];
    
    [self setupTimer];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self setUpGestureRecognizers];
    
}

- (NSString *)playerScore
{
    
    self.cluesCount = self.correctGuess + self.skippedClues;
    
    return [NSString stringWithFormat: @"%ld/%ld", (long)self.correctGuess, (long)self.cluesCount ];
    ;
    
}

- (void)shuffled
{
    
    uint32_t shuffleClues = arc4random_uniform([_data.clues count]);
    
    NSString *randomClue = [_data.clues objectAtIndex:shuffleClues];
    
    self.cluesLabel.text = randomClue;
}


#pragma mark - Timer stuff

- (void)setupTimer
{
    //create a timer NSTimer, then add it to the NSRunLoop
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    self.timerCount = 5;
    
    [timer fire];
    
}

- (void)timerFired:(NSTimer *)timer
{
    NSString *convertedToString = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    self.timerLabel.text = convertedToString;
    
    self.timerCount--;
    
    if (self.timerCount == 0) {
        [timer invalidate];
        
//        if (visibleViewCntroller.isViewLoaded && visibleViewController.view.window)
//        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:self.playerScore
                                                           delegate:self
                                                  cancelButtonTitle:@"Done"
                                                  otherButtonTitles:nil];
            [alert show];
//        }
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked Done
    if (buttonIndex == 0) {
        
        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

- (void)setUpGestureRecognizers
{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [UIColor greenColor];
            self.correctGuess++;
            [self shuffled];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor redColor];
            self.skippedClues++;
            [self shuffled];
            break;
            
        default:
            return;
            
    }
}

@end

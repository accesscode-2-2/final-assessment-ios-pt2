//
//  TopicsDetailVC.m
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TopicsDetailVC.h"
#import "TopicsTVC.h"
#import <AVFoundation/AVFoundation.h>
#import "NYAlertViewController.h"


@interface TopicsDetailVC ()

@property (nonatomic) NSArray *topicClueList;

@property (nonatomic) NSTimer *changeBgColourTimer;
@property (nonatomic, assign) NSInteger timerCount;
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;

@property (nonatomic, assign) NSInteger totalClues;
@property (nonatomic, assign) NSInteger cluesCorrect;
@property (nonatomic, assign) NSInteger cluesWrong;

@property(nonatomic, strong) AVAudioPlayer *backgroundMusic;

@end

@implementation TopicsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestureRecognizers];
    [self generateClue];
    [self setupTimer];
}

-(void) playWinSound {
    NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"10_purchase"
                                               withExtension:@"wav"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                  error:nil];
    self.backgroundMusic.numberOfLoops = 0;
    [self.backgroundMusic play];
}

-(void) playlossSound {
    NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"cranker swipe"
                                               withExtension:@"wav"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                  error:nil];
    self.backgroundMusic.numberOfLoops = 0;
    [self.backgroundMusic play];
}

-(void) playGameOver{
    NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"you lose"
                                               withExtension:@"wav"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                  error:nil];
    self.backgroundMusic.numberOfLoops = 0;
    [self.backgroundMusic play];
}


-(void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 30;
    
    [timer fire];
}

-(void) generateClue {
    self.topicClueList = self.clues.topicClues;
    
    uint32_t rnd = arc4random_uniform([self.clues.topicClues count]);
    
    NSString *randomObject = [self.clues.topicClues objectAtIndex:rnd];
    
    self.topicsClueLbl.text = randomObject;
}

-(void) setupGestureRecognizers {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
}

-(void) bGColourTimer {
    self.changeBgColourTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
}

-(void) changeBackground {
    [UIView animateWithDuration:.2 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:33.0/255.0 blue:36.0/255.0 alpha:1];
    } completion:NULL];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    switch (gesture.direction ) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [UIColor greenColor];
            [self bGColourTimer];
            [self generateClue];
            [self playWinSound];
            self.totalClues++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor redColor];
            [self bGColourTimer];
            [self generateClue];
            [self playlossSound];
            self.totalClues++;
            self.cluesWrong++;
            break;
        default:
            return;
    }
}

-(void)gameOverAlert {
    
    self.cluesCorrect =  self.totalClues - self.cluesWrong;

    NSString *totalClues = [NSString stringWithFormat:@"%li", (long)self.totalClues];
    NSString *cluesCorrect = [NSString stringWithFormat:@"%li", (long)self.cluesCorrect];
    NSString *playerResult = [NSString stringWithFormat:@"%@/%@", cluesCorrect, totalClues];

    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    
    // Set a title and message
    alertViewController.title = NSLocalizedString(@"Game Over", nil);
    alertViewController.message = NSLocalizedString(playerResult, nil);
    
    // Customize appearance as desired
    alertViewController.buttonCornerRadius = 20.0f;
    alertViewController.view.tintColor = self.view.tintColor;
    
    alertViewController.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:19.0f];
    alertViewController.messageFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
    alertViewController.cancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:alertViewController.cancelButtonTitleFont.pointSize];
    
    alertViewController.swipeDismissalGestureEnabled = YES;
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    
    alertViewController.alertViewBackgroundColor = [UIColor colorWithRed:31.0/255.0 green:33.0/255.0 blue:36.0/255.0 alpha:1];
    alertViewController.titleColor = [UIColor colorWithRed:197.0/255.0 green:111.0/255.0 blue:251.0/255.0 alpha:1];
    alertViewController.messageColor = [UIColor whiteColor];
    alertViewController.cancelButtonColor = [UIColor colorWithRed:197.0/255.0 green:111.0/255.0 blue:251.0/255.0 alpha:1];
    
    // Add alert actions
    [alertViewController addAction:[NYAlertAction actionWithTitle:NSLocalizedString(@"Done", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(NYAlertAction *action) {
                                                              [self dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
    
    // Present the alert view controller
    [self presentViewController:alertViewController animated:YES completion:nil];
}

-(void)timerFired:(NSTimer *)timer {
    if (self.timerCount == 0) {
        [timer invalidate];
        [self gameOverAlert];
        [self playGameOver];
    }
    
    //determine time left on timer
    NSString *convertedToString = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    self.timerLbl.text = convertedToString;
    
    self.timerCount--;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"
#import "ZoomInOutAnimation.h"

@interface GameViewController ()
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger getReadyTimerCount;
@property (weak, nonatomic) IBOutlet UIView *getReadyView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessItLabel;
@property (nonatomic) NSInteger pointsTotal;
@property (nonatomic) NSInteger index;

@end

@implementation GameViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.selectedCategory [@"title"];
    [self setupGestureRecognizer];
    [self getReadyTimer];
    NSLog(@"yooooo %@", self.selectedCategory);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timeLabel.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Get Ready

-(void)getReadyTimer{
    
    [ZoomInOutAnimation pulseView:self.getReadyView from:1.0 to:2.5 withDuration:0.5 repeats:CGFLOAT_MAX];

    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(getReadyTimerFired:) userInfo:nil repeats:YES];
    self.getReadyTimerCount = 5;
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)getReadyTimerFired:(NSTimer *)timer{
    
    self.getReadyTimerCount --;
    NSString *convertedString = [[NSNumber numberWithInteger:self.getReadyTimerCount] stringValue];
    if (self.getReadyTimerCount < 4) {
    self.guessItLabel.text = convertedString;
    }
    else {
        self.guessItLabel.text = @"Get Ready!";
    }
    if (self.getReadyTimerCount == 0) {
        [timer invalidate];
        [ZoomInOutAnimation stopZoomingView:self.getReadyView];
        [self startGame];
    }
}

#pragma mark - Start Game

-(void)startGame{
    self.timeLabel.hidden = NO;
    self.pointsTotal = 0;
    self.index = 0;
    self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
    [self setupTimer];
}

-(void)setupTimer{
    
    NSTimer *timer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    self.timerCount = 9;
    [timer fire];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)timerFired:(NSTimer *)timer{
    
    self.timerCount --;
    if (self.timerCount == 0) {
         [timer invalidate];
        [self gamesOverAlertView];
    }
    
    NSString *convertedString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.timeLabel.text = convertedString;
    
}

#pragma mark - Gesture Recognizers

-(void)setupGestureRecognizer{
    
    UISwipeGestureRecognizer *leftSwipeSkip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    leftSwipeSkip.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipeCorrect = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    rightSwipeCorrect.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipeSkip];
    [self.view addGestureRecognizer:rightSwipeCorrect];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    if (self.timerCount != 0) {
        self.index ++;
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
                
                [self animateViewWithColor:[UIColor redColor]];
                self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
                NSLog(@"pointsTotal left %ld", (long)self.pointsTotal);
                
                break;
                
            case UISwipeGestureRecognizerDirectionRight:
                [self animateViewWithColor:[UIColor greenColor]];
                
                self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
                self.pointsTotal ++;
                NSLog(@"pointsTotal %ld", (long)self.pointsTotal);
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Animations

-(void)animateViewWithColor:(UIColor *)color {
    [UIView animateWithDuration:0 animations:^{
        self.view.backgroundColor = color;
    }];
    [UIView animateWithDuration:0.35 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
}

#pragma mark - Alert View

-(void)gamesOverAlertView{
    
    NSString *message = [NSString stringWithFormat:@"%ld/%ld",(long)self.pointsTotal, (long)self.index];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game's over"
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [alert show];

}




@end

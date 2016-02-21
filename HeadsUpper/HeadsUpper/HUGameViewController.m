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

- (void)shuffled;

@end

@implementation HUGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTimer];
    [self setUpGestureRecognizers];
    
    [self shuffled];
    
    NSLog(@"%@", self.cluesLabel.text);
    
    
}

- (void)shuffled
{
    
    //    NSUInteger count = [_data.clues count];
    //
    //    if (count < 1) return;
    //    for (NSUInteger i = 0; i < count - 1; ++i) {
    //        NSInteger remainingCount = count - i;
    //        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
    //        [_data.clues exchangeObjectAtIndex:i withObjectAtIndex: exchangeIndex];
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
    if (self.timerCount == 0) {
        [timer invalidate];
        
        //
        //        self.timerCount = 10;
    }
    
    // Determine time left on timer
    NSString *convertedToString = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    self.timerLabel.text = convertedToString;
    
    self.timerCount--;
}

- (void)setUpGestureRecognizers
{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
//    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
//    [self.view addGestureRecognizer:downSwipe];
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [UIColor greenColor];
            [self shuffled];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor redColor];
            [self shuffled];
            break;
//        case UISwipeGestureRecognizerDirectionDown:
//            self.view.backgroundColor = [UIColor yellowColor];
//            
            break;
        default:
            return;
            
    }
}

@end

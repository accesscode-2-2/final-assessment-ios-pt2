//
//  HUGameScreenViewController.m
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameScreenViewController.h"
#import "HUTopicsTableViewController.h"

@interface HUGameScreenViewController ()

@property (nonatomic) NSInteger timerCount;
@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation HUGameScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestureRecognizer];
    [self setUpTimer];
//self.clueLabel.text = 
}

#pragma mark Timer Implementation

- (void)setUpTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 15;
    
    [timer fire];
}

- (void)timerFired:(NSTimer *)timer
{
    // create a reference count
    if (self.timerCount < 0) {
        // [timer invalidate];
        self.timerCount = 15;
    }
    
    NSString *intToString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.timerLabel.text = intToString;
    
    self.timerCount--;
}

#pragma mark Swipe Implementation

- (void)setupGestureRecognizer
{
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget: self
                                           action: @selector(handleSwipe :)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget: self
                                            action: @selector(handleSwipe :)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget: self
                                           action: @selector(handleSwipe :)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:downSwipe];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            self.view.backgroundColor = [UIColor redColor];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            
            self.view.backgroundColor = [UIColor greenColor];
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            
            break;
    }
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self showAlert];
    }
}


-(void)showAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"HeadsUpper"
                              message:@"Correct!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}


@end

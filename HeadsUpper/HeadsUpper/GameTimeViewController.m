//
//  GameTimeViewController.m
//  HeadsUpper
//
//  Created by Shena Yoshida on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTimeViewController.h"
#import "GameModel.h"

@interface GameTimeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger timerCount;



// track score
// track category array index


@end

@implementation GameTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.topicLabel.text = [self.category.items objectAtIndex:0];
    
    [self setupTimer];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    
    [timer fire]; // start timer
}

- (void)timerFired:(NSTimer *)timer {
    
     NSString *time = [[NSNumber numberWithInteger:self.timerCount]stringValue];
    
    if (self.timerCount < 1) {
        [timer invalidate];
        
        // here's where we will bump to next question
        
        // reset timer and label:
        self.timerCount = 0;
        self.timerLabel.text = time;
    }
    
    self.timerCount --;
    

    self.timerLabel.text = time;
}







@end

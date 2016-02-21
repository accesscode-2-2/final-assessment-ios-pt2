//
//  TopicsDetailVC.m
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TopicsDetailVC.h"
#import "TopicsTVC.h"

@interface TopicsDetailVC ()

@property (nonatomic) NSArray *topicClueList;

@property (nonatomic) NSTimer *changeBgColourTimer;
@property (nonatomic, assign) NSInteger timerCount;
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;

@end

@implementation TopicsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestureRecognizers];
    [self generateClue];
    
    [self setupTimer];
    
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
        self.view.backgroundColor = [UIColor whiteColor];
    } completion:NULL];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    switch (gesture.direction ) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [UIColor greenColor];
            [self bGColourTimer];
            [self generateClue];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor redColor];
            [self bGColourTimer];
            [self generateClue];
            break;
        default:
            return;
    }
}

-(void)gameOverAlert {
    UIAlertController * alert = [UIAlertController
                                  alertControllerWithTitle:@"My Title"
                                  message:@"Enter User Credentials"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

    
}

-(void)timerFired:(NSTimer *)timer {
    if (self.timerCount == 0) {
        [timer invalidate];
        [self gameOverAlert];
        
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

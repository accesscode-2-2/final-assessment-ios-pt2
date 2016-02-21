//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (nonatomic) NSInteger timerCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessItLabel;
@property (nonatomic) NSInteger pointsTotal;
@property (nonatomic) NSInteger index;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.selectedCategory [@"title"];
    [self setupTimer];
    [self setupGestureRecognizer];
    self.pointsTotal = 0;
    self.index = 0;
    
    NSLog(@"yooooo %@", self.selectedCategory);
    self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

-(void)setupGestureRecognizer{
    
    UISwipeGestureRecognizer *leftSwipeSkip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    leftSwipeSkip.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipeCorrect = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    rightSwipeCorrect.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipeSkip];
    [self.view addGestureRecognizer:rightSwipeCorrect];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    
    self.index ++;
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
            NSLog(@"pointsTotal left %ld", (long)self.pointsTotal);

            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            self.guessItLabel.text = self.selectedCategory[@"subjects"][self.index];
            self.pointsTotal ++;
            NSLog(@"pointsTotal %ld", (long)self.pointsTotal);
            break;
            
        default:
            break;
    }
    
}

-(void)gamesOverAlertView{
    
    NSString *message = [NSString stringWithFormat:@"%ld/%ld",(long)self.pointsTotal, (long)self.index];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game's over"
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [alert show];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

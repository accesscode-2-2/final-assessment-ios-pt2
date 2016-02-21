//
//  HUViewController.m
//  HeadsUpper
//
//  Created by Daniel Distant on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUViewController.h"

@interface HUViewController ()

@property (weak, atomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (atomic) NSTimer *timer;

@property (weak, nonatomic) NSDate *timeStarted;

@property (atomic) NSTimeInterval gameTime;

@property (atomic) NSDateFormatter *dateFormatter; //or

@property (atomic) NSInteger timerCounter; //or

@property (atomic) NSTimer *colorTimer;

@property (strong, atomic) NSMutableArray *tempAnswers;

@property (atomic) NSInteger answerCounter;

@property (atomic) NSInteger totalCounter;

@property (atomic) NSInteger colorCounter;

@end

@implementation HUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGame];

}

-(void)viewDidAppear:(BOOL)animated {
    
    [self nextAnswer:self.answers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupGame {
    
    self.gameTime = 15;
    
    self.answerCounter = 0;
    
    self.totalCounter = 0;
    
    self.tempAnswers = [[NSMutableArray alloc] initWithArray:self.answers];
    
//    self.dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [self.dateFormatter setDateFormat:@"ss.SS"];
    
    [self setupTimer];
}

- (void) setupTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.timerLabel.text = @"15";
    
    self.timeStarted = [NSDate date];
    
    self.timerCounter = self.gameTime;
    
}

- (void) timerFired:(NSTimer *)timer {
    
    self.timerCounter--;
    
    NSDate *currentTime = [NSDate date];
    
    NSTimeInterval timeDifference = [currentTime timeIntervalSinceDate:self.timeStarted];
    
    if ((timeDifference >= self.gameTime) || (self.timerCounter < 1)) {
        [self endGame];
    } else {
        
//        NSString *dateString = [NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:self.timeStarted]];
//        
//        self.timerLabel.text = dateString;
        
        self.timerLabel.text = [NSString stringWithFormat:@"%ld", self.timerCounter];
        
    }
}

#pragma mark -- game methods

- (IBAction)correctTapGestureTapped:(id)sender {
    
    self.answerCounter++;
    
    [self nextAnswer:self.tempAnswers];
    
    [self backgroundColorFlash:[UIColor greenColor]];
}


- (IBAction)passSwipeGestureSwiped:(id)sender {
    
    //for passes to mean player loses a point, uncomment the code below
    
    //    self.answerCounter--;
    //
    //    if (self.answerCounter < 0) {
    //        self.answerCounter = 0;
    //    }
    
    [self nextAnswer:self.tempAnswers];
    
    [self backgroundColorFlash:[UIColor redColor]];
}


- (NSString *) nextAnswer:(NSArray *)array {
    
    if (self.tempAnswers.count) {
        //getting a random answer from the array
        
        self.totalCounter++;
        
        u_int32_t rand = (u_int32_t)array.count;
        int idx = arc4random_uniform(rand);
        
        NSString *pickedAnswer = array[idx];
        
        [self.tempAnswers removeObject:pickedAnswer];
        
        self.answerLabel.text = pickedAnswer;
        
        return pickedAnswer;
    }
    
    [self endGame];
    
    return @"";
}

-(void) backgroundColorFlash:(UIColor *)color {
    
    NSTimer *colorTimer = [NSTimer timerWithTimeInterval:0.07 target:self selector:@selector(changeColor:) userInfo:color repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:colorTimer forMode:NSRunLoopCommonModes];
    
}

-(void) changeColor:(NSTimer *)timer {
    
    if ([self.view.backgroundColor isEqual:[timer userInfo]]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.colorCounter++;
    } else {
        self.view.backgroundColor = [timer userInfo];
        self.colorCounter++;
    }
    
    if (self.colorCounter >= 5) {
        [timer invalidate];
        self.view.backgroundColor = [UIColor whiteColor];
        self.colorCounter = 0;
    }
}

- (void) endGame {
    
    self.answerLabel.text = @"GAME OVER!";
    self.timerLabel.text = @"00";
    [self.timer invalidate];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    if (self.answerCounter >= self.totalCounter / 2) {
        [self statusAlertDidAppearWithTitle:@"Great job!" andMessage: [NSString stringWithFormat:@"Noice! You answered %lu out of %lu correctly!", self.answerCounter, self.totalCounter]];
    } else {
        [self statusAlertDidAppearWithTitle:@"You need more practice!" andMessage:[NSString stringWithFormat: @"Yikes! You only answered %lu out of %lu correctly!", self.answerCounter, self.totalCounter]];
    }
    
}

- (void) statusAlertDidAppearWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

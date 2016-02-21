//
//  detailViewController.m
//  HeadsUpper
//
//  Created by Umar on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "detailViewController.h"
#import "gameTableViewController.h"

@interface detailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, assign) NSInteger timerCounter;
@property (nonatomic, assign) NSInteger rightSwipeCounter;
@property (nonatomic, assign) NSInteger leftSwipeCounter;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
//@property (weak, nonatomic) NSTimer *timer;
//@property (weak, nonatomic) NSArray *holdingArray;


@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTimer];
    [self setupGestureRecognizers];
    
    //sample
    NSString *random =[self.holdingArray objectAtIndex: arc4random() % [self.holdingArray count]];
    self.gameLabel.text = random;
    
//    NSLog(@"%@", [self.holdingArray objectAtIndex:0]);
    NSLog(@"%ld", (long)self.leftSwipeCounter);
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [self.timer invalidate];
//    self.timer = nil;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTimer{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timerCounter = 8;
    [timer fire];
}

- (void)timerFired: (NSTimer *)timer{
    // check current timer against the time when the timer was created
    // creata a refenrce counter
    
    if (self.timerCounter == 0){
        [timer invalidate];
        
        // very important
        self.timerCounter = 0;
        
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                                                       message:@"This is an alert."
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert ];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:@"Your score is: "
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    NSString *time = [[NSNumber numberWithInteger: self.timerCounter] stringValue];
    self.timerLabel.text = time;
    
    self.timerCounter--;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setupGestureRecognizers{
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *righttSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    righttSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:righttSwipe];
    
}

- (void)handleSwipe: (UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            self.leftSwipeCounter = 0;
            self.leftSwipeCounter++;
            
            //animate
            self.view.backgroundColor = [UIColor redColor];
            
            NSString *random =[self.holdingArray objectAtIndex: arc4random() % [self.holdingArray count]];
            self.gameLabel.text = random;
            
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
        {
            self.rightSwipeCounter = 0;
            self.rightSwipeCounter++;
            
            //animate
            self.view.backgroundColor = [UIColor greenColor];
            //get value of random index from array
            NSString *random =[self.holdingArray objectAtIndex: arc4random() % [self.holdingArray count]];
            self.gameLabel.text = random;
        }
            break;
            
        default:
            return;
    }
}

@end

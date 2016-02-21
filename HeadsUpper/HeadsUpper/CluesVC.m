//
//  CluesVC.m
//  HeadsUpper
//
//  Created by C4Q on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "CluesVC.h"
#import <ChameleonFramework/Chameleon.h>
#import <SIAlertView/SIAlertView.h>

@interface CluesVC ()
@property (weak, nonatomic) IBOutlet UILabel *clueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic)NSInteger timerCount;
@property (nonatomic) NSInteger rightCount;
@property (nonatomic) NSInteger answerNumber;
@property (nonatomic) NSInteger totalGuesses;
@end


@implementation CluesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.answerNumber = 0;
    self.rightCount = 0;
    self.totalGuesses = 1;
    self.clueLabel.text = self.listClues[self.answerNumber];
    
     [self setupTimer];
    
}

# pragma mark - gesture methods
- (void) setUpGestureRecognizers {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction= UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
}

- (void) handleSwipe: (UISwipeGestureRecognizer *) gesture {
    switch (gesture.direction) {
        case  UISwipeGestureRecognizerDirectionRight:
            [self animateViewWith:[UIColor redColor]];
            self.answerNumber++;
            self.totalGuesses++;
            self.clueLabel.text = self.listClues[self.answerNumber];
            
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self animateViewWith:[UIColor greenColor]];
            self.rightCount++;
            self.totalGuesses++;
            self.answerNumber++;
            self.clueLabel.text = self.listClues[self.answerNumber];
            break;
        default:
            break;
    }
}


-(void) animateViewWith:(UIColor* )color{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.backgroundColor = color;
                     } completion:^(BOOL finished) {
                         self.view.backgroundColor = [UIColor whiteColor];
                     }];
}



//timer methods
-(void) setupTimer
{
    self.timerCount = 10;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(handleGameTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //[timer fire];
    [self setUpGestureRecognizers];
}

- (void) handleGameTimer: (NSTimer * ) timer {
    
    
    self.timerLabel.text = [NSString stringWithFormat: @"%ld", (long)self.timerCount];
    self.timerCount--;
    
    if (self.timerCount < 0 ) {
        [timer invalidate];
        
        //show score
        NSString * endGameText = [NSString stringWithFormat:@"you got %ld out of %ld right", (long)self.rightCount, self.totalGuesses];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Game Over" andMessage:endGameText];
        
        [alertView addButtonWithTitle:@"Play Again"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alert) {
                                  
                              }];
        
        alertView.didDismissHandler = ^(SIAlertView *alertView) {
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        
        [alertView show];
        
        
        //end game
        
    }
    
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

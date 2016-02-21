//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Xiulan Shi on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"
#import "CategoryModel.h"

@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (nonatomic, assign) NSInteger timerCount;

@property (nonatomic) NSMutableArray *questions;

@property (nonatomic) NSInteger totalCount;
@property (nonatomic) NSInteger correctCount;


@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.questions = [self.category.questions mutableCopy];
    
    self.questionLabel.text = [self nextQuestion];
    
    [self setupTimer];
    [self setupGestureRecognizers];
    
}


- (NSString*) nextQuestion {
    
    NSString *question;
    if (self.questions.count > 0) {
        int size = (int)[self.questions count] - 1;
        int r = arc4random_uniform(size);
        question = self.questions[r];
        
        // also need to remove integer
        
    }
    else  {NSLog(@"no more unique questions"); }
    
    return question;
}


- (void)setupTimer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    
    [timer fire];
    
}

- (void)timerFired:(NSTimer *)timer {
    
    if (self.timerCount == 0) {
        [timer invalidate];
        [self showAlert];
       
    }
    
    // determine time left on timer
    
    NSString *string = [[NSNumber numberWithInteger: self.timerCount] stringValue];
    
    self.timerLabel.text = string;
    
    self.timerCount--;
    
    
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"%ld/%ld", self.correctCount, self.totalCount] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
    
    [alert show];
}


- (void)setupGestureRecognizers
{
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget: self
                                           action: @selector(handleSwipe :)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget: self
                                            action: @selector(handleSwipe :)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];

}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1];
            [UIView beginAnimations:@"fade out" context:nil];
            [UIView setAnimationDuration:0.8];
            self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
            [UIView commitAnimations];
            self.totalCount += 1;
            self.questionLabel.text = [self nextQuestion];
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:1];
            [UIView beginAnimations:@"fade out" context:nil];
            [UIView setAnimationDuration:0.8];
            self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
            [UIView commitAnimations];
            self.correctCount += 1;
            self.totalCount += 1;
            self.questionLabel.text = [self nextQuestion];
            break;
            
        default:
            return;
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

//
//  ViewController.m
//  HeadsUpper
//
//  Created by Michael Kavouras on 2/17/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) NSString *message;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger totalScore;

@property (nonatomic) NSTimer *countDown;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self randomClue];
    [self timerCountDown];

}

- (void)viewDidAppear:(BOOL)animated
{
    [self gestures];
}

- (void)gestures
{
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipManager:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipManager:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.view addGestureRecognizer:left];
    [self.view addGestureRecognizer:right];
    
}

- (void)swipManager:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            self.view.backgroundColor = [UIColor redColor];
            self.correct++;
            [self randomClue];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            self.view.backgroundColor = [UIColor greenColor];
            self.incorrect++;
            [self randomClue];
            break;
            
            
        default:
            return;
            
    }
}

-(NSString *)scoreKeeper
{
    self.totalScore = self.correct + self.incorrect;
    return self.message = [NSString stringWithFormat:@"%i/%i", self.correct, self.incorrect];
}

-(void) randomClue
{
    NSUInteger shuffleSubjects = arc4random_uniform(self.data.subject.count);
    
    NSString *shuffledSubject = [self.data.subject objectAtIndex: shuffleSubjects];
    
    self.gameLabel.text = shuffledSubject;
    
    
}

-(void) timerCountDown
{
    self.count = 20;
    self.countDown = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(startCounting)
                                                    userInfo:nil
                                                     repeats:YES];
}

-(void)startCounting
{
    self.count--;
    self.timerLabel.text = [NSString stringWithFormat:@"%i", self.count];
    
    if (self.count == 0) {
        [self.countDown invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over"
                              message:self.scoreKeeper
                              delegate:self
                              cancelButtonTitle:@"Done"
                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
}

/* found resource here http://stackoverflow.com/questions/25806040/how-to-unwind-segues-from-uialertview-button */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Using buttonIndex you could find whether OK or CANCEL is pressed and perform your popToRootViewController call.
    //Below on OK press then moving to root VC
    if (buttonIndex==0)
    {
        //OK is pressed...
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}




@end

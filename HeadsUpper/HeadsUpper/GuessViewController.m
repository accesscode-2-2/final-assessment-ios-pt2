//
//  GuessViewController.m
//  HeadsUpper
//
//  Created by Bereket  on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GuessViewController.h"
#import "SubjectsObjectModel.h"
#import "SubjectsTableViewController.h"

@interface GuessViewController ()
@property (strong, nonatomic) IBOutlet UIView *gestureView;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *countDown;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger arrayCount;


@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayCount = 0;
    if ([SubjectsObjectModel sharedManager].topicNumber == 0){
        self.answersArray = [[NSMutableArray alloc] initWithArray:[SubjectsObjectModel sharedManager].superStarsArray];
        
    }
    else if([SubjectsObjectModel sharedManager].topicNumber == 1){
         self.answersArray = [[NSMutableArray alloc] initWithArray:[SubjectsObjectModel sharedManager].iconsArray];
        
    }
    else if([SubjectsObjectModel sharedManager].topicNumber == 2){
         self.answersArray = [[NSMutableArray alloc] initWithArray:[SubjectsObjectModel sharedManager].animalsGoneWildArray];
        
    }
    [self setupGestureRecognizer];
    
    self.subjectLabel.text = self.answersArray[self.arrayCount];

    // Do any additional setup after loading the view.
}

- (void)setupGestureRecognizer {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget: self
                                           action: @selector(handleSwipe :)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget: self
                                            action: @selector(handleSwipe :)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [self.gestureView addGestureRecognizer:leftSwipe];
    [self.gestureView addGestureRecognizer:rightSwipe];
    
    [self setUpTimer];
}



- (void)setUpTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 30;
    
    [timer fire];
}

- (void)timerFired:(NSTimer *)timer
{
    // create a reference count
    if (self.timerCount < 1 && [SubjectsObjectModel sharedManager].scoreCount != self.answersArray.count) {
        // [timer invalidate];
        
        
        [timer invalidate];
       NSString*messageString = [NSString stringWithFormat:@"Your score was %ld", (long)[SubjectsObjectModel sharedManager].scoreCount];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                         message: messageString                                                      delegate:self
                                              cancelButtonTitle:@"Start Over"
                                               otherButtonTitles:nil];
        [alert show];
    }
    
    else if([SubjectsObjectModel sharedManager].scoreCount == self.answersArray.count){
        [timer invalidate];
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message: @"YOU WIN"                                                      delegate:self
                                              cancelButtonTitle:@"Start Over"
                                              otherButtonTitles:nil];

        [alert show];
    }
    
    else if (self.arrayCount == self.answersArray.count && [SubjectsObjectModel sharedManager].scoreCount != self.answersArray.count)
        
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message: @"Start Over"                                                      delegate:self
                                              cancelButtonTitle:@"Start Over"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
    NSString *stringCount = [NSString stringWithFormat:@"%ld", self.timerCount];
    self.countDown.text = stringCount;
    
    self.timerCount--;
    
    NSLog(@"%ld", (long)self.timerCount);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) { // Set buttonIndex == 0 to handel "Ok"/"Yes" button response
        // Cancel button response
        SubjectsTableViewController* viewController = [[SubjectsTableViewController alloc] init];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:viewController animated:NO completion:nil];
    }}

- (void)handleSwipe: (UISwipeGestureRecognizer *)gesture {
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            self.gestureView.backgroundColor = [UIColor redColor];
            [SubjectsObjectModel sharedManager].scoreCount--;
            self.subjectLabel.text = self.answersArray[self.arrayCount];
           
            self.arrayCount++;

            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            
            self.gestureView.backgroundColor = [UIColor greenColor];
            [SubjectsObjectModel sharedManager].scoreCount++;
            self.subjectLabel.text = self.answersArray[self.arrayCount];
            
            self.arrayCount++;
            

            break;
            

            
        default:
            
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

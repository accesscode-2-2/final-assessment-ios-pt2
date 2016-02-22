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
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSTimer *countDown;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // self.gameLabel.text = self.category;
    [self randomClue];
    [self timerCountDown];

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
    self.countDown = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCounting) userInfo:nil repeats:YES];
}

-(void)startCounting
{
    self.count--;
    self.timerLabel.text = [NSString stringWithFormat:@"%i", self.count];
    
    if (self.count == 0) {
        [self.countDown invalidate];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over"
                              message:nil
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

-(void)gestures
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

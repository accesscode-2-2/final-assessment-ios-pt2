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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

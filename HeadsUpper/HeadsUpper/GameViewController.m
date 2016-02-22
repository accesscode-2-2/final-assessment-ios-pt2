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

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // self.gameLabel.text = self.category;
    [self randomClue];
}

-(void) randomClue
{
    NSUInteger suffleSubjects = arc4random_uniform(self.data.subject.count);
    
    NSString *shuffledSubject = [self.data.subject objectAtIndex: suffleSubjects];
    
    self.gameLabel.text = shuffledSubject;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

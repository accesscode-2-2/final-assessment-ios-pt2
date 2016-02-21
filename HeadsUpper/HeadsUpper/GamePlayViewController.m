//
//  GamePlayViewController.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GamePlayViewController.h"

@interface GamePlayViewController ()

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger subjectsPresented;

@property (nonatomic) NSTimer* gameTimer;
@property (nonatomic) NSInteger timeRemaining;

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.score = 0;
    self.subjectsPresented = 1;
    self.timeRemaining = 10;
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"%ld",(long)self.timeRemaining];
    
    self.gameSubjects = [self shuffleArray:self.gameSubjects];
    self.subjectLabel.text = self.gameSubjects[self.subjectsPresented - 1];
    
    [self setupGestureRecognizers];
    [self setupTimer];
}

-(void)setupGestureRecognizers{
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
}

-(void)setupTimer{
    //create timer
    self.gameTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    // add timer to run loop
    [[NSRunLoop currentRunLoop] addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture{
    
    CABasicAnimation* fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    switch (gesture.direction) {
            
        case UISwipeGestureRecognizerDirectionLeft:
            fade.fromValue = (id)[UIColor redColor].CGColor;
            self.score--;
            if (self.score < 0) { self.score = 0;}
            break;

        case UISwipeGestureRecognizerDirectionRight:
            fade.fromValue = (id)[UIColor greenColor].CGColor;
            self.score++;
            break;
            
        default:
            break;
    }
    
    fade.toValue = (id)[UIColor whiteColor].CGColor;
    [fade setDuration:1];
    [self.view.layer addAnimation:fade forKey:@"fadeAnimation"];
    
    if (self.gameSubjects[self.subjectsPresented - 1] != nil) {
        self.subjectsPresented++;
        self.subjectLabel.text = self.gameSubjects[self.subjectsPresented - 1];
    }
}

-(void)update{
    if (self.timeRemaining > 0) {
        self.timeRemaining--;
        self.timeRemainingLabel.text = [NSString stringWithFormat:@"%ld", self.timeRemaining];
    } else{
        //GAME OVER
        [self.gameTimer invalidate];
        
        NSString *messageString = [NSString stringWithFormat:@"Score:%ld/%ld",(long)self.score,(long)self.subjectsPresented];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"GAME OVER"
                                                                       message:messageString
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(NSArray*)shuffleArray:(NSArray*)arr{
    
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithArray:arr];
    
    NSUInteger count = [myArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [myArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    NSArray *shuffledArray = [myArray copy];
    return shuffledArray;
}


@end

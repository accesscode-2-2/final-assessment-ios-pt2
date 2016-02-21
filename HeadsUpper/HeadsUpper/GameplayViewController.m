//
//  GameplayViewController.m
//  HeadsUpper
//
//  Created by Jamaal Sedayao on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameplayViewController.h"
#import "GameSummaryViewController.h"

@interface GameplayViewController ()
@property (nonatomic,strong) AVAudioPlayer *audioPlayerOne;
@property (nonatomic,strong) AVAudioPlayer *audioPlayerTwo;
           
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *clueLabel;
@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) NSInteger timeLeft;

@property (nonatomic) NSMutableSet * correctGuesses;
@property (nonatomic) NSMutableSet * wrongGuesses;
@property (nonatomic) NSString * itemDisplayed;
//
@property (strong, nonatomic) IBOutlet UIButton *testButton;



@end

@implementation GameplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self autoRotateLandscape];
    [self becomeFirstResponder];
    [self addSwipeGesture];
    [self startGameTimer];
    [self setupAudioPlayer];
    
    [self randomDisplayFromCategoryArray];
    
    self.correctGuesses = [[NSMutableSet alloc]init];
    self.wrongGuesses = [[NSMutableSet alloc]init];
   // self.categoryItemsUsed = [[NSMutableArray alloc]init];
    
    NSLog(@"Dictionary Passed: %@",self.categoryPlayed);
    NSLog(@"Dictionary Data:%@",self.categoryArray);
    
    self.testButton.hidden = YES;
    
}

- (void)autoRotateLandscape {
    //autorotate  landscape
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)startGameTimer{
    
    self.gameTimer = [NSTimer timerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(handleTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.gameTimer forMode:NSDefaultRunLoopMode];
    
    self.timeLeft = 20;
}

- (void)handleTimer:(NSTimer*)timer{
    self.timeLeft--;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%ld",self.timeLeft];
    
    if (self.timeLeft < 6){
        self.timerLabel.textColor = [UIColor redColor];
    }
    
    if (self.timeLeft == 0){
        NSLog(@"ZERO!");
        [self.gameTimer invalidate];
        [self performSegueWithIdentifier:@"endGameSegue" sender:self];
    }
    
}

- (IBAction)randomButton:(UIButton *)sender {
    
    //Testing
    
    //[self randomDisplayFromCategoryArray];
    
    //[self performSegueWithIdentifier:@"endGameSegue" sender:self];

}

- (void)randomDisplayFromCategoryArray{
    
    NSUInteger randomIndex = arc4random() % [self.categoryArray count];
    NSString *displayItem = [self.categoryArray objectAtIndex:randomIndex];
    self.itemDisplayed = displayItem;
    self.clueLabel.text = displayItem;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

//shakeMotion - CORRECT ANSWER

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake){
        NSLog(@"called");
        [self.audioPlayerTwo play];
        [self.correctGuesses addObject:self.itemDisplayed];
        [self createFlash:[UIColor greenColor]];
        [self randomDisplayFromCategoryArray];
        
        NSLog(@"Correct Guesses:%@", self.correctGuesses);
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//Swipe gesture - WRONG ANSWER

- (void)addSwipeGesture{
    self.view.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe Down Works!");
        [self.wrongGuesses addObject:self.itemDisplayed];
        [self.audioPlayerOne play];
        [self createFlash:[UIColor redColor]];
        
        
        [self randomDisplayFromCategoryArray];
        NSLog(@"Wrong Guesses:%@",self.wrongGuesses);
    }
    
}

- (void)createFlash:(UIColor*)color{
    
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.bounds];
    flashView.backgroundColor = color;
    flashView.alpha = 1.0;
    
    // Add the flash view to the window
    
    [self.view addSubview:flashView];
    
    // Fade it out and remove after animation.
    
    [UIView animateWithDuration:0.5 animations:^{
        flashView.alpha = 0.0;
    }      completion:^(BOOL finished){
        [flashView removeFromSuperview];
    }];
}

- (void)setupAudioPlayer{
    
    //self.audioPlayer = [[AVAudioPlayer alloc]init];
    
    NSString *pathOne  = [[NSBundle mainBundle] pathForResource:@"DamnDaniel" ofType:@"m4a"];
    NSURL *soundUrlOne = [NSURL fileURLWithPath:pathOne];
    NSError *error;
    self.audioPlayerOne = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrlOne error:&error];
    [self.audioPlayerOne prepareToPlay];
    
    NSString *pathTwo  = [[NSBundle mainBundle] pathForResource:@"RightAnswer" ofType:@"m4a"];
    NSURL *soundUrlTwo = [NSURL fileURLWithPath:pathTwo];
    self.audioPlayerTwo = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrlTwo error:&error];
    [self.audioPlayerTwo prepareToPlay];
    

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    GameSummaryViewController *destinationVC = [segue destinationViewController];
    destinationVC.correctSet = self.correctGuesses;
    destinationVC.wrongSet = self.wrongGuesses;
    
}


@end

//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Jackie Meggesto on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "AudioPlayer.h"
#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic) AudioPlayer* audioPlayer;

@property (nonatomic) NSTimer* mainTimer;
@property (nonatomic) NSTimer* readyTimer;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger readyCounter;
@property (nonatomic) NSInteger mainCounter;
@property (nonatomic) NSInteger correctAnswers;

@property (nonatomic) UISwipeGestureRecognizer* leftSwipe;
@property (nonatomic) UISwipeGestureRecognizer* rightSwipe;


@end

@implementation GameViewController

- (void)viewDidLoad {
    
    self.audioPlayer = [[AudioPlayer alloc]initWithAudioPlayers];
    self.correctAnswers = 0;
    self.readyCounter = 3;
    self.mainCounter = 60;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}
-(void)viewDidAppear:(BOOL)animated
{

    [self setUpReadyTimer];
}

#pragma mark Gesture Recognition

-(void)setUpGestureRecognizer
{
    
    self.leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
    
}
-(void)handleSwipe:(UISwipeGestureRecognizer*)gesture
{
    if(self.gameDataArray.count > 0)
    {
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
                
                
                [self.gameDataArray removeObjectAtIndex:self.gameDataArray.count-1];
                self.mainLabel.text = [self.gameDataArray lastObject];
                [self.audioPlayer.incorrectPlayer play];
                
                break;
            case UISwipeGestureRecognizerDirectionRight:
                
                [self.gameDataArray removeObjectAtIndex:([self.gameDataArray count] - 1)];
                self.mainLabel.text = [self.gameDataArray lastObject];
                self.correctAnswers++;
                [self.audioPlayer.correctPlayer play];
                break;
                
            default:
                NSLog(@"something's not right");
                break;
        }
    
    } else {
        
        self.mainLabel.text = @"All out of questions!";
        [self.mainTimer invalidate];
        
    }
    
    
    
}
-(void)removeGestureRecognizers
{
    
    [self.view removeGestureRecognizer:self.leftSwipe];
     [self.view removeGestureRecognizer:self.rightSwipe];
    
}

#pragma mark Timer Methods
-(void)setUpReadyTimer
{
    
    self.readyTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireReadyTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.readyTimer forMode:NSRunLoopCommonModes];
    
}
-(void)fireReadyTimer:(NSTimer*)timer
{
    
    
    if(self.readyCounter == 0) {
        
        self.mainLabel.text = self.gameDataArray[0];
        [timer invalidate];
        [self setUpMainTimer];
        [self setUpGestureRecognizer];
        
    } else {
        self.mainLabel.text = [NSString stringWithFormat:@"%ld", self.readyCounter];
        self.readyCounter -= 1;
    }
    

}
-(void)setUpMainTimer
{
    
    self.mainTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(fireMainTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.mainTimer forMode:NSRunLoopCommonModes];
    
}
-(void)fireMainTimer
{
    self.timerLabel.text = [NSString stringWithFormat:@"%ld", self.mainCounter];
    if(self.mainCounter <= 0) {
        
        self.mainLabel.text = @"0";
        [self.audioPlayer.incorrectPlayer play];
        self.mainLabel.text = [NSString stringWithFormat:@"Game over! \n You got %ld right!", self.correctAnswers];
        [self.mainTimer invalidate];
        [self removeGestureRecognizers];
    
    } else if (self.correctAnswers == 6) {
        
        self.mainLabel.text = @"Fabulous!";
        [self.mainTimer invalidate];
        [self removeGestureRecognizers];
        
    } else {
        
        self.timerLabel.text = [NSString stringWithFormat:@"%ld", self.mainCounter];
        self.mainCounter--;
        
        
    }
}
@end

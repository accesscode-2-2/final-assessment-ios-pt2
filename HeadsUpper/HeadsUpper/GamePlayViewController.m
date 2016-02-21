//
//  GamePlayViewController.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GamePlayViewController.h"
#import "GameManager.h"
#import <AVFoundation/AVFoundation.h>


@interface GamePlayViewController ()<GameManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *correctButton;
@property (weak, nonatomic) IBOutlet UIButton *wrongButton;
@property (nonatomic) AVAudioPlayer *player;


@property (nonatomic) GameManager *gameManager;


@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameManager = [[GameManager alloc] init];
    self.gameManager.gameManagerDelegate = self;
    
    [self.startGameButton setTitle:@"Start" forState:UIControlStateNormal];
    
}

-(void) generateWord {
    NSString *option = self.category.categoryOptions[arc4random_uniform((u_int32_t)self.category.categoryOptions.count)];
    self.mainLabel.text = option;
    
}

- (IBAction)startGameButtonTapped:(id)sender {
    
    if ([self.startGameButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.gameManager startGame];
        [self.startGameButton setTitle:@"Keep Going" forState:UIControlStateNormal];
        self.scoreLabel.text = 0;
        [self generateWord];
    }
}
- (IBAction)correctButtonTapped:(id)sender {
    [self.gameManager correctAnswer];
    [self generateWord];
}

- (IBAction)wrongButtonTapped:(id)sender {
    [self.gameManager wrongAnswer];
    [self generateWord];
}

-(void)updateCountdown:(NSInteger)countDown {
    self.timerLabel.text = [@(countDown) stringValue];
    if ([self.timerLabel.text isEqualToString:@"0"]) {
        self.mainLabel.text = @"ANOTHER ONE 🔑";
        [self playSound];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:nil];
        });
        
    }
}

-(void)updateScore:(NSUInteger)score {
    self.scoreLabel.text = [@(score) stringValue];

}

- (void)playSound {
    
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AnotherOne" ofType:@"mp3"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    [self.player play];
}


@end

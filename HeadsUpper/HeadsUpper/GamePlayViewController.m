//
//  GamePlayViewController.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GamePlayViewController.h"
#import "GameManager.h"


@interface GamePlayViewController ()<GameManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (nonatomic) GameManager *gameManager;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *correctButton;
@property (weak, nonatomic) IBOutlet UIButton *wrongButton;

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameManager = [[GameManager alloc] init];
    self.gameManager.gameManagerDelegate = self;
    
    [self.startGameButton setTitle:@"Start" forState:UIControlStateNormal];
    
    
//    NSString *categoryOption = self.category.categoryOptions;
//    cell.textLabel.text = categoryOption;
    
}

-(void) generateWord {
    NSString *option = self.category.categoryOptions[arc4random_uniform((u_int32_t)self.category.categoryOptions.count)];
    self.mainLabel.text = option;
    
}

- (IBAction)startGameButtonTapped:(id)sender {
    
    if ([self.startGameButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.gameManager startGame];
        [self.startGameButton setTitle:@"Pause" forState:UIControlStateNormal];
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
}

-(void)updateScore:(NSUInteger)score {
    self.scoreLabel.text = [@(score) stringValue];
}



@end

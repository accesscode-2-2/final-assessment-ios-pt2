//
//  HUGameViewController.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUGameViewController.h"
#import "HUInstructionsView.h"
#import "HUData.h"
#import "UIColor+FadeColor.h"
#import "NSArray+Shuffle.h"
#import <CoreMotion/CoreMotion.h>

@interface HUGameViewController ()<HUInstructionsProtocol>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) BOOL inAnswerState;
@property (nonatomic) HUInstructionsView *instructionView;
@property (nonatomic) NSArray *questionsArray;
@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSMutableDictionary *correctQuestion;
@property (nonatomic) NSInteger timerLoopCount;
@property (nonatomic) CMMotionManager *motionManager;

@end

@implementation HUGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionsArray = [[HUData sharedData] dataForCategory:self.category];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.currentIndex = 0;
    self.correctQuestion = [NSMutableDictionary new];
    self.timerLoopCount = 15;
    [self shuffle];
    [self trackAccelerometer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.gameTimer) {
        [self setupInstructionView];
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.instructionView = nil;
    if (self.gameTimer) {
        [self formatTimer];
    }
}
#pragma mark - In Game Methods

- (void)startGame {
    [self displayQuestionForIndex:self.currentIndex];
    [self formatTimer];
}

- (void)displayQuestionForIndex:(NSInteger)index {
    self.questionLabel.text = self.questionsArray[index];
}

- (void)nextQuestion {
    self.currentIndex++;
    if (self.currentIndex < self.questionsArray.count) {
        [self displayQuestionForIndex:self.currentIndex];
    }else{
        [self endGame];
    }

}

- (void)skipQuestion{
    [self animateToColorFade:OrangeColor];
}

- (void)correctlyAnswered{
    self.correctQuestion[@(self.currentIndex)] = @(self.currentIndex);
    [self animateToColorFade:GreenColor];

}

- (void)formatTimer{
    if (!self.gameTimer) {
        self.gameTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
    } else{
        [self.gameTimer invalidate];
        self.gameTimer = nil;
    }
}

- (void)updateTimerLabel {
    self.timerLoopCount--;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld",self.timerLoopCount];

    if (self.timerLoopCount <= 5){
        self.timerLabel.textColor = [UIColor redColor];
    }else{
        self.timerLabel.textColor = [UIColor blackColor];
    }
    
    if (self.timerLoopCount == 0) {
        [self endGame];
    }
}

- (void)endGame {
    [self formatTimer];
    [self launchAlert];

}
#pragma mark - Fade Animation

- (void)animateToColorFade:(ColorFade)fade {

    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:.35 animations:^{
        weakSelf.view.backgroundColor = [UIColor colorForFadeType:fade];
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:.25 animations:^{
            weakSelf.view.backgroundColor = [UIColor whiteColor];
        }
            completion:^(BOOL finished) {
                [weakSelf nextQuestion];

        }];
    }];
}

- (void)shuffle {
    self.questionsArray = [NSArray shuffle:self.questionsArray];
}

#pragma mark - Instruction View Setup/Delegate

- (void)didTapStartButton{

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
    
        weakSelf.instructionView.frame = CGRectMake(weakSelf.view.center.x,weakSelf.view.center.y,0,0);
    }completion:^(BOOL finished) {
        [weakSelf.instructionView removeFromSuperview];
        weakSelf.instructionView = nil;
        [weakSelf startGame];
    }];

}

- (void)setupInstructionView {
    self.instructionView = [[[NSBundle mainBundle] loadNibNamed:@"HUInstructionsView" owner:self options:nil] firstObject];
    self.instructionView.frame = CGRectMake(0, 74, self.view.bounds.size.width-70, self.view.bounds.size.height - 150);
    self.instructionView.center = self.view.center;
    self.instructionView.layer.cornerRadius = 20;

    [self.view addSubview:self.instructionView];

    self.instructionView.delegate = self;
}

- (void)trackAccelerometer {
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 1.0f/60.0f;

    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
            withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                    [self handleAccelerometer:accelerometerData.acceleration];
                        if(error){
                            NSLog(@"No Data for accel");
                        }
        }];
}

- (void)handleAccelerometer:(CMAcceleration)acceleration {
    if (self.gameTimer) {
        if (!self.inAnswerState) {
            if (acceleration.z > 0.85f) {
                self.inAnswerState = YES;
                [self correctlyAnswered];
            }
            else if(acceleration.z < -0.85f){
                self.inAnswerState = YES;
                [self skipQuestion];
            }
        }
        else{
            if (acceleration.z < .2f && acceleration.z > -.2f) {
                self.inAnswerState = NO;
            }
        }
    }
}

#pragma mark - Alert
- (void)launchAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Stats!" message:[NSString stringWithFormat:@"You scored %ld out of %ld",self.correctQuestion.allKeys.count, self.questionsArray.count] preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OMG YES!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
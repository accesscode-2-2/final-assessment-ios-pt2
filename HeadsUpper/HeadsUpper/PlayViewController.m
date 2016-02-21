//
//  PlayViewController.m
//  HeadsUpper
//
//  Created by Artur Lan on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *countDown;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic, assign) NSInteger totalSwipes;
@property (nonatomic, assign) NSInteger rightSwipes;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rightSwipes = 0;
    self.totalSwipes = 0;
    [self updateLabel];
    [self setupTimer];
    [self setupGestureRecognizers];
    


}

- (void)updateLabel {
    
    NSUInteger random = arc4random_uniform((uint32_t)self.nameValue.count);
    
    self.label.text = self.nameValue[random];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    
    [timer fire];
    
}

- (void)timerFired:(NSTimer *)timer {
    //stop timer in 10 secs
    //int count reference
    
    if (self.timerCount == 0) {
        [timer invalidate];
        
        self.timerCount = 0;
        [self gameOver];
        
    }
    //update timer label
    NSString *convertedToString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.countDown.text = convertedToString;

    self.timerCount--;
}

- (void)setupGestureRecognizers {
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    
    
    
}
- (void)gameOver {
    NSString *message = [NSString stringWithFormat:@"%ld/%ld", (long)self.rightSwipes, (long)self.totalSwipes];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"Done"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
    [alertController addAction:actionDone];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self backgroundGlowAnimationFromColor:[UIColor redColor] toColor:[UIColor whiteColor] clearAnimationsFirst:YES];
            [self updateLabel];
            self.totalSwipes++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self backgroundGlowAnimationFromColor:[UIColor greenColor] toColor:[UIColor whiteColor] clearAnimationsFirst:YES];
            [self updateLabel];
            self.rightSwipes++;
            self.totalSwipes++;
            break;
            
            
        default:
            break;
    }
}

- (void)backgroundGlowAnimationFromColor:(UIColor *)startColor toColor:(UIColor *)destColor clearAnimationsFirst:(BOOL)reset {
    if (reset) {
        [self.view.layer removeAllAnimations];
    }
    
    CABasicAnimation *background = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    background.duration = 1.00;
    background.repeatCount = 0;
    background.autoreverses = NO;
    background.fromValue = (id) startColor.CGColor;
    background.toValue = (id) destColor.CGColor;
    [self.view.layer addAnimation:background forKey:@"backgroundColor"];
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

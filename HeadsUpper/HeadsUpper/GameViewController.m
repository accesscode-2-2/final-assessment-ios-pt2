//
//  GameViewController.m
//  HeadsUpper
//
//  Created by Diana Elezaj on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameViewController.h"
#import "ZoomInOutAnimation.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (nonatomic) NSInteger timerCount;
@property (nonatomic) NSInteger getReadyTimerCount;
@property (weak, nonatomic) IBOutlet UIView *getReadyView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessItLabel;
@property (nonatomic) NSInteger pointsTotal;
@property (nonatomic) NSMutableArray *generatedNumbers;
@property (nonatomic) NSTimer *readyTimer;
@property (nonatomic) NSTimer *startGameTimer;
@property (nonatomic) BOOL inAnswerState;
@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) AVCaptureVideoPreviewLayer *aVCaptureVideoPreviewLayer;
@end

@implementation GameViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.selectedCategory [@"title"];
    [self setupGestureRecognizer];
    [self trackAccelerometer];
    [self getReadyTimer];
    [self startLiveVideo];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.timeLabel.hidden = YES;
    self.view.layer.cornerRadius = 30;
    self.view.layer.masksToBounds = YES;
    self.view.layer.borderColor = [UIColor blueColor].CGColor;
    self.view.layer.borderWidth = 10;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_readyTimer invalidate];
    [_startGameTimer invalidate];
    
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    float rotation;
    
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait) {
        rotation = 0;
    } else
        if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
            rotation = M_PI/2;
        } else
            if (toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
                rotation = -M_PI/2;
            }
    
    [UIView animateWithDuration:duration animations:^{
        _cameraView.transform = CGAffineTransformMakeRotation(rotation);
        _aVCaptureVideoPreviewLayer.bounds = self.view.bounds;
        _aVCaptureVideoPreviewLayer.frame = self.view.frame;
        
 
        _cameraView.bounds = self.view.bounds;
    }];
}



-(void)startLiveVideo{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        session.sessionPreset = AVCaptureSessionPresetHigh;
        
        AVCaptureDevice *newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];;

        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:&error];
        [session addInput:input];
        
        _aVCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        _aVCaptureVideoPreviewLayer.frame = self.view.bounds;
    
        [self.cameraView.layer addSublayer:_aVCaptureVideoPreviewLayer];
        self.cameraView.alpha = 0.4;
        [self.view addSubview:self.cameraView];
        
        self.gameView.frame = self.view.frame;
        [self.view addSubview:self.gameView];
        [session startRunning];
        
    }
}


- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position) return device;
    }
    return nil;
}

#pragma mark - Get Ready

-(void)getReadyTimer{
    
    [ZoomInOutAnimation pulseView:self.getReadyView from:1.0 to:2.5 withDuration:0.5 repeats:CGFLOAT_MAX];

    _readyTimer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(getReadyTimerFired:) userInfo:nil repeats:YES];
    self.getReadyTimerCount = 5;
    [_readyTimer fire];
    [[NSRunLoop currentRunLoop] addTimer:_readyTimer forMode:NSRunLoopCommonModes];
}

-(void)getReadyTimerFired:(NSTimer *)timer{
    
    self.getReadyTimerCount --;
    NSString *convertedString = [[NSNumber numberWithInteger:self.getReadyTimerCount] stringValue];
    if (self.getReadyTimerCount < 4) {
    self.guessItLabel.text = convertedString;
    }
    else {
        self.guessItLabel.text = @"Get Ready!";
    }
    if (self.getReadyTimerCount == 0) {
        [timer invalidate];
        [ZoomInOutAnimation stopZoomingView:self.getReadyView];
        [self startGame];
    }
}

#pragma mark - Start Game

-(void)startGame{
    self.timeLabel.hidden = NO;
    self.pointsTotal = 0;
    self.guessItLabel.text = self.subjectsArray[[self generateRandomNumber]];
    [self setupTimer];
}

-(void)setupTimer{
    
    _startGameTimer =  [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    self.timerCount = 61;
    [_startGameTimer fire];
    
    [[NSRunLoop currentRunLoop] addTimer:_startGameTimer forMode:NSRunLoopCommonModes];
}

-(void)timerFired:(NSTimer *)timer{
 
    self.timerCount --;
    if (self.timerCount == 0) {
         [timer invalidate];
        [self gamesOverAlertView];
    }
    
    NSString *convertedString = [[NSNumber numberWithInteger:self.timerCount] stringValue];
    self.timeLabel.text = convertedString;
    
}

#pragma mark - Gesture Recognizers

-(void)setupGestureRecognizer{
    
    UISwipeGestureRecognizer *leftSwipeSkip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    leftSwipeSkip.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipeCorrect = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    rightSwipeCorrect.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:leftSwipeSkip];
    [self.view addGestureRecognizer:rightSwipeCorrect];
    
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    if (self.timerCount != 0) {
        switch (gesture.direction) {
            case UISwipeGestureRecognizerDirectionLeft:
                [self skipIt];
                break;
                
            case UISwipeGestureRecognizerDirectionRight:
                [self correctAnswer];
                break;
                
            default:
                break;
        }
    }
}

-(void)correctAnswer{
    [self animateViewWithColor:[UIColor greenColor]];
    self.guessItLabel.text = self.subjectsArray[[self generateRandomNumber ]];
    if (self.pointsTotal == self.subjectsArray.count) {
        [self startGameTimer];
        [self gamesOverAlertView];
    }
    else {
    self.pointsTotal ++;
    }
}

-(void)skipIt{
    [self animateViewWithColor:[UIColor redColor]];
    self.guessItLabel.text = self.subjectsArray[[self generateRandomNumber]];
}

//- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
//{
//    if (self.timerCount != 0) {
//        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//        //Face Up
//        if (orientation == UIDeviceOrientationFaceDown)
//        {
//            [self correctAnswer];
//        }
//        // Face down
//        else if (orientation == UIDeviceOrientationFaceUp)
//        {
//            [self skipIt];
//        }
//    }
//}

#pragma mark - Animations

-(void)animateViewWithColor:(UIColor *)color {
    [UIView animateWithDuration:0 animations:^{
        self.view.backgroundColor = color;
    }];
    [UIView animateWithDuration:0.35 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
}

#pragma mark - Alert View

-(void)gamesOverAlertView{
    
    NSString *message = [NSString stringWithFormat:@"%ld/%ld",(long)self.pointsTotal, (long)self.generatedNumbers.count-1];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game's over"
                                                message:message
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [alert show];

}

-(NSInteger) generateRandomNumber {
    NSInteger randomNumber = (NSInteger) arc4random_uniform((int)self.subjectsArray.count-2); //because the last one shouldn't be counted
    if ([self.mutableArrayContainingNumbers containsObject: [NSNumber numberWithInteger:randomNumber]]) {
        return [self generateRandomNumber];
    } else {
        if (self.generatedNumbers.count < self.subjectsArray.count) {
        [self.mutableArrayContainingNumbers addObject: [NSNumber numberWithInteger:randomNumber]];
        }
    }
    return randomNumber;
}


-(NSMutableArray *) mutableArrayContainingNumbers
{
    if (!_generatedNumbers)
        _generatedNumbers = [[NSMutableArray alloc] init];
    
    return _generatedNumbers;
}

- (BOOL)shouldAutorotate
{
    [super shouldAutorotate];
    return YES;
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
    if (self.startGameTimer) {
        if (!self.inAnswerState) {
            if (acceleration.z > 0.85f) {
                self.inAnswerState = YES;
                [self correctAnswer];
            }
            else if(acceleration.z < -0.85f){
                self.inAnswerState = YES;
                [self skipIt];
            }
        }
        else{
            if (acceleration.z < .2f && acceleration.z > -.2f) {
                self.inAnswerState = NO;
            }
        }
    }
}



@end

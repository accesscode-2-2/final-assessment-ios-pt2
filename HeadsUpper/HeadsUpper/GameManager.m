//
//  GameManager.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameManager.h"
#import "MotionGesture.h"


@interface GameManager ()<MotionGestureDelegate>

@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger score;

@property(nonatomic) MotionGesture *motionGesture;

@end


@implementation GameManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [self generalSetup];
        self.score = 0;
        
    }
    return self;
}

-(void)generalSetup {
    self.motionGesture = [[MotionGesture alloc] init];
    self.motionGesture.motionGestureDelegate = self;
}

-(void) startGame {
//our alloc init
    [self setupTimer];
    
}

-(void)timerDone {
    [self.timer invalidate];
}

-(void)setupTimer {
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerfired:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.timerCount = 10;
    [self.timer fire];
}

-(void)timerfired:(NSTimer *)timer {
    
    self.timerCount--;
    [self.gameManagerDelegate updateCountdown:self.timerCount];
    if (self.timerCount == 0 ) {
        [self.timer invalidate];
   
    }
}

-(void)setScore:(NSInteger)score {
    _score = score;
    [self.gameManagerDelegate updateScore:score];
}

-(void) correctAnswer {
    self.score++;

}

-(void) wrongAnswer {
    if (self.score != 0) {
        self.score--;
    }
    
}

-(void)tiltUp {
    [self correctAnswer];
}

-(void)tiltDown {
    [self wrongAnswer];
}

//-(void) gameEnded {
//self.t
//}

@end

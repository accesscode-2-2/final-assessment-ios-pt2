//
//  GameManager.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameManager.h"


@interface GameManager ()

@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger score;

@end


@implementation GameManager

-(void) startGame {
//our alloc init
    [self setupTimer];
    
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
    self.score--;
    
}

@end

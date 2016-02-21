//
//  GameManager.h
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameManagerDelegate <NSObject>

-(void)updateCountdown:(NSInteger) countDown;
-(void)updateScore:(NSUInteger) score;


@end


@interface GameManager : NSObject

@property (nonatomic, weak) id<GameManagerDelegate> gameManagerDelegate;

-(void) startGame;
-(void) correctAnswer;
-(void) wrongAnswer;

@end

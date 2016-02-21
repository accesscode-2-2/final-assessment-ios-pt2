//
//  AudioPlayer.m
//  HeadsUpper
//
//  Created by Jackie Meggesto on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

-(id)initWithAudioPlayers
{
    
    if(self == [super init]) {
        
         NSString *correctPath = [NSString stringWithFormat:@"%@/correct.wav", [[NSBundle mainBundle] resourcePath]];
         NSString *incorrectPath = [NSString stringWithFormat:@"%@/incorrect.mp3", [[NSBundle mainBundle] resourcePath]];
        
        NSURL *correctSoundURL = [NSURL fileURLWithPath:correctPath];
        NSURL *incorrectSoundURL = [NSURL fileURLWithPath:incorrectPath];
        
        self.correctPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:correctSoundURL error:nil];
        self.incorrectPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:incorrectSoundURL error:nil];
        self.correctPlayer.volume = 0.6;
        self.incorrectPlayer.volume = 0.6;

        return self;
        
    } else {
        return nil;
    }
    
    
}

@end

//
//  AudioPlayer.h
//  HeadsUpper
//
//  Created by Jackie Meggesto on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : NSObject

@property (nonatomic) AVAudioPlayer* correctPlayer;
@property (nonatomic) AVAudioPlayer* incorrectPlayer;

-(id)initWithAudioPlayers;

@end

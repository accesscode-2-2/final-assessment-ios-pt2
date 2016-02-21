//
//  GameView.h
//  HeadsUpper
//
//  Created by Justine Kay on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *correctPassLabel;
@property (weak, nonatomic) IBOutlet UILabel *introCountdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

//
//  HUInstructionsView.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUInstructionsView.h"

@implementation HUInstructionsView

- (IBAction)startButtonTapped:(UIButton *)sender {
    sender.hidden = YES;
    [self clearAllLabels];
    [self.delegate didTapStartButton];
}

- (void)clearAllLabels {
    for (UILabel *label in self.labels) {
        label.text = @"";
    }
}

@end

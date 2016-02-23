//
//  GestureManager.m
//  HeadsUpper
//
//  Created by Brian Blanco on 2/22/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GestureManager.h"
#import "GameViewController.h"

@implementation GestureManager

- (void)gestures
{
    GameViewController *vc = [[GameViewController alloc] init];
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipManager:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipManager:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [vc.view addGestureRecognizer:left];
    [vc.view addGestureRecognizer:right];
    
}

- (void)swipManager:(UISwipeGestureRecognizer *)gesture
{
    GameViewController *vc = [[GameViewController alloc] init];
    switch (gesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            vc.view.backgroundColor = [UIColor redColor];
            vc.correct++;
            [vc randomClue];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            vc.view.backgroundColor = [UIColor greenColor];
            vc.incorrect++;
            [vc randomClue];
            break;
            
            
        default:
            return;
            
    }
}



@end

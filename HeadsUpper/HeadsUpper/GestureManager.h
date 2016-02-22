//
//  GestureManager.h
//  HeadsUpper
//
//  Created by Brian Blanco on 2/22/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GestureManager : NSObject

- (void)gestures;
- (void)swipManager:(UISwipeGestureRecognizer *)gesture;

@end

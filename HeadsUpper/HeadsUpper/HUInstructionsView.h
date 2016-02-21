//
//  HUInstructionsView.h
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HUInstructionsProtocol <NSObject>

- (void)didTapStartButton;

@end

@interface HUInstructionsView : UIView
@property (nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic) id <HUInstructionsProtocol> delegate;

@end

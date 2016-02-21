//
//  TopicSelectionTableViewCell.m
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TopicSelectionTableViewCell.h"

@implementation TopicSelectionTableViewCell

- (void)awakeFromNib {
    
    CGFloat borderWidth = 10.0f;
    
    self.topicsImg.frame = CGRectInset(self.frame, -borderWidth, -borderWidth);
    self.topicsImg.layer.borderColor = [UIColor colorWithRed:253.0/254.0 green:119.0/254.0 blue:163.0/254.0 alpha:1].CGColor;
    self.topicsImg.layer.borderWidth = borderWidth;
   
    self.topicsImg.layer.cornerRadius = 20.0;
    self.topicsImg.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

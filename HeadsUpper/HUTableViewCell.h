//
//  HUTableViewCell.h
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUTableViewCell : UITableViewCell

@property (nonatomic) HUCategory category;
@property (nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (instancetype)initWithCategory:(HUCategory)category;

@end

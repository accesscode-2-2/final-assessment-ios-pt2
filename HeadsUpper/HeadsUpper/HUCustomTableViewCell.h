//
//  HUCustomTableViewCell.h
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUCustomTableViewCell : UITableViewCell

@property (nonatomic) NSString *topicName;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@end

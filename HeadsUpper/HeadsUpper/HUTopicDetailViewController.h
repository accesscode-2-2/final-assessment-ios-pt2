//
//  HUTopicDetailViewController.h
//  HeadsUpper
//
//  Created by Eric Sze on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUTopicDetailViewController : UIViewController

@property (nonatomic) NSArray *topicAnswers;

@property (nonatomic) NSString *topicTitle;

@property (weak, nonatomic) IBOutlet UILabel *topicAnswerTextLabel;

@end

//
//  TopicsDetailVC.h
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topics.h"
#import "TopicsTVC.h"

@interface TopicsDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *topicsClueLbl;
@property (weak, nonatomic) NSString *topicName;
@property (nonatomic) Topics *clues;





@end

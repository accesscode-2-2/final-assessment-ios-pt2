//
//  HUTopicDetailViewController.m
//  HeadsUpper
//
//  Created by Eric Sze on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTopicDetailViewController.h"
#import "HUTableViewController.h"

@interface HUTopicDetailViewController ()

@end

@implementation HUTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.topicTitle;
    
    
    
    NSUInteger n = self.topicAnswers.count;
    NSLog(@"%lu", (unsigned long)n);
    
    NSUInteger randIdx = arc4random_uniform((uint32_t)n);
    self.topicAnswerTextLabel.text = self.topicAnswers[randIdx];
    
    
    NSLog(@"%@", self.topicAnswers[randIdx]);
    NSLog(@"%@", self.topicAnswers);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

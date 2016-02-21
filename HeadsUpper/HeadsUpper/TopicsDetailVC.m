//
//  TopicsDetailVC.m
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TopicsDetailVC.h"
#import "TopicsTVC.h"

@interface TopicsDetailVC ()

@property (nonatomic) NSArray *topicClueList;

@end

@implementation TopicsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clues.topicClues = self.topicClueList;
    
    uint32_t rnd = arc4random_uniform([self.clues.topicClues count]);
    
    NSString *randomObject = [self.clues.topicClues objectAtIndex:rnd];
    
    self.topicsClueLbl.text = randomObject;
    
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

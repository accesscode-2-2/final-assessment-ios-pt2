//
//  GameTopicsTableVC.m
//  Part-Two
//
//  Created by Fatima Zenine Villanueva on 2/21/16.
//  Copyright © 2016 Kaira. All rights reserved.
//

#import "GameTopicsTableVC.h"
#import "GameManager.h"
#import "ViewController.h"

@interface GameTopicsTableVC ()

@property (nonatomic) NSMutableDictionary *gameTopics;

@end

@implementation GameTopicsTableVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.gameTopics = [GameManager sharedManager].gameTopics;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.gameTopics.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTopicID" forIndexPath:indexPath];
    
    NSMutableDictionary *gameTopics = [GameManager sharedManager].gameTopics;
    NSArray *keys = [gameTopics allKeys];
    NSString *topic = keys[indexPath.row];
    
    cell.textLabel.text = topic;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"OhSayCanYouSee"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ViewController *destinationVC = segue.destinationViewController;
        
        NSMutableDictionary *gameTopics = [GameManager sharedManager].gameTopics;
        
        NSArray *keys = [gameTopics allKeys];
        
        NSString *topic = keys[indexPath.row];
        
        destinationVC.topicCards = [self.gameTopics objectForKey:topic];
    }
}

@end

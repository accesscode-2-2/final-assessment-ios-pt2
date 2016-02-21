//
//  GameTopicTableViewController.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTopicTableViewController.h"
#import "GameTopicDataModel.h"

@interface GameTopicTableViewController ()

@property (nonatomic) NSArray *gameTopicsList;
@property (nonatomic) NSDictionary *gameDataDictionary;

@end

@implementation GameTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GameTopicDataModel getGameDataWithCompletionHander:^(NSDictionary *gameData) {
        self.gameDataDictionary = [[NSDictionary alloc] initWithDictionary:gameData];
        self.gameTopicsList = [[NSArray alloc] initWithArray: [gameData allKeys]];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gameTopicsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTopicCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.gameTopicsList[indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

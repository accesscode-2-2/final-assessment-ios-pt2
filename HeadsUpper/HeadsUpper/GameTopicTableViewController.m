//
//  GameTopicTableViewController.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTopicTableViewController.h"
#import "GameDataManager.h"
#import "GamePlayViewController.h"

@interface GameTopicTableViewController ()

@property (nonatomic) NSArray *gameTopicsList;
@property (nonatomic) NSDictionary *gameDataDictionary;

@end

@implementation GameTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GameDataManager getGameDataWithCompletionHander:^(NSDictionary *gameData) {
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    GamePlayViewController *gamePlayVC = [segue destinationViewController];
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSString *selectedTopic = self.gameTopicsList[selectedIndexPath.row];
    gamePlayVC.gameSubjects = [[NSArray alloc] initWithArray: self.gameDataDictionary[selectedTopic]];
}

@end

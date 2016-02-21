//
//  GameTopicTableViewController.m
//  HeadsUpper
//
//  Created by Z on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameTopicTableViewController.h"
#import "GameTopicDataModel.h"
#import "GamePlayViewController.h"

@interface GameTopicTableViewController ()

@property (nonatomic) GameTopicDataModel *model;

@end

@implementation GameTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[GameTopicDataModel alloc] initWithLoadCompletionBlock:^{
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTopicCell" forIndexPath:indexPath];
    
    NSString *title = [self.model.data[indexPath.row] objectForKey:@"title"];
    cell.textLabel.text = title;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    GamePlayViewController *gamePlayVC = [segue destinationViewController];
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSArray *subjects = [self.model.data[selectedIndexPath.row] valueForKey:@"subjects"];
    gamePlayVC.gameSubjects = subjects;
}

@end

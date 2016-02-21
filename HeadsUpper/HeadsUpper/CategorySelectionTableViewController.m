//
//  CategorySelectionTableViewController.m
//  HeadsUpper
//
//  Created by Xiulan Shi on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "CategorySelectionTableViewController.h"
#import "GameViewController.h"

@interface CategorySelectionTableViewController ()

@end

@implementation CategorySelectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [CategoryModel sharedInstance];
    [self.model initializeModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.model.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    GameCategory *category = [self.model.categories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = category.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GameCategory *currentCategory = [self.model.categories objectAtIndex:indexPath.row];
    GameViewController *detailVC = segue.destinationViewController;
    detailVC.category = currentCategory;

}


@end

//
//  HUTableViewController.m
//  HeadsUpper
//
//  Created by Varindra Hart on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTableViewController.h"
#import "HUTableViewCell.h"
#import "HUCategoryGenerator.h"
#import "HUGameViewController.h"

@interface HUTableViewController ()

@end

@implementation HUTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUTableViewCell" bundle:nil] forCellReuseIdentifier:@"HUCell"];
    self.tableView.estimatedRowHeight = 20.0f;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height/(3.5);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HUTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUCell" forIndexPath:indexPath];

    cell.category = [HUCategoryGenerator categoryForIndex:indexPath.row];
    cell.title = [HUCategoryGenerator getTitleForCategory:cell.category];
    cell.titleLabel.text = cell.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HUGameViewController *gameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];

    gameVC.category = [HUCategoryGenerator categoryForIndex:indexPath.row];

    [self.navigationController pushViewController:gameVC animated:YES];
}

@end

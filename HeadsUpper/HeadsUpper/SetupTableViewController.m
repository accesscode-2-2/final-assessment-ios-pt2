//
//  SetupTableViewController.m
//  HeadsUpper
//
//  Created by Shena Yoshida on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "SetupTableViewController.h"
#import "GameModel.h"
#import "GameTimeViewController.h"
#import "SetupTableViewCell.h"

@interface SetupTableViewController ()

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSInteger itemChosen;

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"HEADS UP!";
    
    GameModel *superstarCategory = [[GameModel alloc] initWithCategoryType:@"Superstars"];
    GameModel *thatsSo90sCategory = [[GameModel alloc] initWithCategoryType:@"That's So 90's"];
    GameModel *heyMrDJCategory = [[GameModel alloc] initWithCategoryType:@"Hey Mr. DJ"];
    GameModel *iconsCategory = [[GameModel alloc] initWithCategoryType:@"Icons"];
    GameModel *animalsGoneWildCategory = [[GameModel alloc] initWithCategoryType:@"Animals Gone Wild"];
    
    self.categories = @[superstarCategory, thatsSo90sCategory, heyMrDJCategory, iconsCategory, animalsGoneWildCategory];
    
    UINib *nib = [UINib nibWithNibName:@"SetupTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cellIdentifier"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    GameModel *thisCategory = [self.categories objectAtIndex:indexPath.row];
    cell.categoryLabel.text = thisCategory.category;
    
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameModel *thisCategory = [self.categories objectAtIndex:indexPath.row];
    GameTimeViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"rootToGameView"];
    dvc.category = thisCategory;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

@end

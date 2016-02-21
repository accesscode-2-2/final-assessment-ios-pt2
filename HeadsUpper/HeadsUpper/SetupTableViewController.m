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
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    
    GameModel *thisCategory = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = thisCategory.category;
    
    // set up category selection/score for detailLabel here
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    GameTimeViewController *gameTimeViewController = segue.destinationViewController;
    
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"rootToGameView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        GameModel *selectedCategory = [self.categories objectAtIndex: indexPath.row];
        gameTimeViewController.category = selectedCategory;
    }
}

@end

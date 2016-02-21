//
//  HUCategoriesTableViewController.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUCategoriesTableViewController.h"
#import "CategoryAndClueSetup.h"
#import "HUGameCategory.h"

@interface HUCategoriesTableViewController ()

@property (nonatomic) NSMutableArray<HUGameCategory *> *categories;

@end

@implementation HUCategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setup];
}

-(void)setup {
    self.categories = [NSMutableArray new];
    CategoryAndClueSetup *categoriesAndClues = [[CategoryAndClueSetup alloc] initCategories];
    self.categories = categoriesAndClues.gameCategories;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCellIdentifier" forIndexPath:indexPath];
    
    HUGameCategory *category = self.categories[indexPath.row];
    
    cell.textLabel.text = category.name;
    
    return cell;
}

@end

//
//  CategoriesTableViewController.m
//  HeadsUpper
//
//  Created by Elber Carneiro on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "QuestionsViewController.h"
#import "QuestionsAPIManager.h"

@interface CategoriesTableViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSDictionary *categories;
@property (nonatomic) NSArray *categoryKeys;

@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self setupCategories];
}

#pragma mark - Setup

- (void)setupCategories {
    
    __weak typeof(self) weakSelf = self;
    [QuestionsAPIManager getQuestionsWithCompletionHandler:^(NSMutableDictionary *categories) {
        
        weakSelf.categories = categories;
        weakSelf.categoryKeys = [weakSelf.categories allKeys];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
        });
        
    }];
    
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categoryKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];

    myCell.textLabel.text = self.categoryKeys[indexPath.row];
        
    return myCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    QuestionsViewController *targetVC = [segue destinationViewController];
    
    targetVC.questions = [self.categories[self.categoryKeys[indexPath.row]] mutableCopy];
}

@end

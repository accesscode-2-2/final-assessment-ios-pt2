//
//  ViewController.m
//  HeadsUpper
//
//  Created by Michael Kavouras on 2/17/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "APIManager.h"
#import "CategoriesTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *categories;
@property GameViewController *gVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"Heads Upper";
    
    UINib *nib = [UINib nibWithNibName:@"CategoriesTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CategoriesTableViewCell"];

    [self fetchData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchData{
    [APIManager getDataWithCompletion:^(NSArray *data) {
        NSLog(@"data %@",data);

        self.categories = data;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.categories.count != 0) {
        return self.categories.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesTableViewCell" forIndexPath:indexPath];
    NSDictionary *categ = self.categories[indexPath.row];
    NSString *name = categ[@"title"];
    cell.titleLabel.text = name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *selectedCategory = self.categories[indexPath.row];
    
    self.gVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Game"];
    self.gVC.selectedCategory = nil;
    self.gVC.selectedCategory = selectedCategory;
    self.gVC.subjectsArray = selectedCategory[@"subjects"];
    [self.navigationController pushViewController:self.gVC animated:YES];
}



@end

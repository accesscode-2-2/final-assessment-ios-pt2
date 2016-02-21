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
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *categories;
@property GameViewController *gVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"Heads Upper";
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EllenCell" forIndexPath:indexPath];

    NSDictionary *categ = self.categories[indexPath.row];
    NSString *name = categ[@"title"];
    cell.textLabel.text = name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSDictionary *selectedCategory = self.categories[indexPath.row];
    
    self.gVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Game"];

    self.gVC.selectedCategory = selectedCategory;
    [self.navigationController pushViewController:self.gVC animated:YES];
}



@end

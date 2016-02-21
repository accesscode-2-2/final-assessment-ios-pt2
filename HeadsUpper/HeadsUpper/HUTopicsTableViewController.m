//
//  HUTopicsTableViewController.m
//  HeadsUpper
//
//  Created by Charles Kang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTopicsTableViewController.h"
#import "HUGameScreenViewController.h"
#import "HUAPIManager.h"

@interface HUTopicsTableViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSArray<NSDictionary *> *subjects;

@end

@implementation HUTopicsTableViewController
@dynamic tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.subjects = [[NSArray alloc] init];
    [self fetchTitleAndSubjects];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUCellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *titlesAndSubjectsDict = self.subjects[indexPath.row];
    NSString *title = titlesAndSubjectsDict[@"title"];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Charles' Methods

- (void)fetchTitleAndSubjects
{
    __weak typeof(self) weakSelf = self;
    
    [HUAPIManager getTitlesAndSubjects:^(NSArray *data) {
        self.subjects = data;
        [weakSelf.tableView reloadData];
    }
     ];
}

@end

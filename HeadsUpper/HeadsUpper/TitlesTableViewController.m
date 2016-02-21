//
//  TitlesTableViewController.m
//  HeadsUpper
//
//  Created by Brian Blanco on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TitlesTableViewController.h"
#import "GameData.h"


@interface TitlesTableViewController ()

@property (nonatomic) NSMutableArray *titleData;
@property (nonatomic) NSArray *titles;
@property (nonatomic) NSMutableDictionary *allTitles;

@end

@implementation TitlesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title" forIndexPath:indexPath];
    
    GameData *titles = [[GameData alloc] init];
    NSString *title = titles.allData[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:]) {
//        <#statements#>
//    }
}

@end

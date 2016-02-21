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

@end

@implementation TitlesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchHeadsUpperAPI];
}

- (void) fetchHeadsUpperAPI
{
    NSURL *topicsURL = [NSURL URLWithString:@"https://heads-up-api.herokuapp.com/"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:topicsURL];
    
    NSError *error = nil;
    
    NSDictionary *topicsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.topics = [NSMutableArray array];
    
   // NSArray *topicsArray = [topicsDictionary objectForKey:@"title"];
    
    for (NSDictionary *tDict in topicsDictionary) {
        GameData *topic = [GameData topicWithTitle:[tDict objectForKey:@"title"]];
        [self.topics addObject:topic];
    }
    
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
    return self.topics.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title" forIndexPath:indexPath];
   
    GameData *topicTitles = [self.topics objectAtIndex:indexPath.row];
    
    cell.textLabel.text = topicTitles.title;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:]) {
//        <#statements#>
//    }
}

@end

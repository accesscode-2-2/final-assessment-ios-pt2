//
//  GameSummaryViewController.m
//  HeadsUpper
//
//  Created by Jamaal Sedayao on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "GameSummaryViewController.h"

@interface GameSummaryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *gameSummaryView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray * correctArray;
@property (nonatomic) NSArray * wrongArray;
@property (strong, nonatomic) IBOutlet UILabel *gameSummaryLabel;
@property (nonatomic) float gamePercentage;

@end

@implementation GameSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoRotatePortrait];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.correctArray = [self.correctSet allObjects];
    self.wrongArray = [self.wrongSet allObjects];
    
    [self getScore];
    
    NSLog(@"Correct Set Passed:%@",self.correctSet);
    NSLog(@"Wrong Set Passed:%@",self.wrongSet);
}

- (void)autoRotatePortrait {
    //autorotate  portrait
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)getScore{
    
    NSMutableArray *allGuesses = [[NSMutableArray alloc]init];
    [allGuesses addObject:self.correctArray];
    [allGuesses addObject:self.wrongArray];
    
    NSInteger correctNumber = self.correctArray.count;
    NSInteger allNumbers = self.correctArray.count + self.wrongArray.count;
    
    float percentage = (100 * correctNumber)/allNumbers;
    
    self.gamePercentage = percentage;
    
    if (self.gamePercentage >= 50.0){
        self.gameSummaryView.backgroundColor = [UIColor greenColor];
    } else {
        self.gameSummaryView.backgroundColor = [UIColor redColor];
    }
    
    NSString *endGameMessage = [NSString stringWithFormat:@"%ld of %ld questions answered correctly. That is %.1f percent, buddy!",correctNumber,(long)allNumbers,percentage];
 
    self.gameSummaryLabel.text = endGameMessage;
}

- (IBAction)playAgainTapped:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - TABLEVIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0){
        return self.correctArray.count;
    } else {
        return self.wrongArray.count;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    if(section == 0){
        return @"Correct!";
    } else {
        return @"Wrong Guesses";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameSummaryIdentifier" forIndexPath:indexPath];
    
    
    if (indexPath.section == 0){
        NSString *correctString = self.correctArray[indexPath.row];
        cell.textLabel.text = correctString;
    } else {
        NSString *wrongString = self.wrongArray[indexPath.row];
        cell.textLabel.text = wrongString;
    }
    
    return cell;
}
@end

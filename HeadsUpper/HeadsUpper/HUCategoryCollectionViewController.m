//
//  HUCategoryCollectionViewController.m
//  HeadsUpper
//
//  Created by Jason Wang on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUCategoryCollectionViewController.h"
#import "DataManager.h"
#import "HUCategoryCellCollectionViewCell.h"
#import "GuessViewController.h"

@interface HUCategoryCollectionViewController ()

@property (nonatomic) NSDictionary *data;
@property (nonatomic) NSArray *allkeys;

@end

@implementation HUCategoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [DataManager headsUpData];
    self.allkeys = [self.data allKeys];
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:(UICollectionViewCell *)sender];
    NSLog(@"indexPath %@",indexPath);
    UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
    GuessViewController *destViewController = [[nav viewControllers] lastObject];
    NSString *category = [self.allkeys objectAtIndex:indexPath.row];
    destViewController.guessTerms = [self.data objectForKey:category];
    destViewController.category = category;
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allkeys.count;
}

//    NSDictionary *dataDict = @{@"Super Stars" : superStars, @"That's so 90s" : the90s, @"Hey Mr. DJ" : mrDJ, @"Icons" : icons, @"Animals Gone Wild":animalsGoneWild};

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HUCategoryCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCellID" forIndexPath:indexPath];
    cell.label.text = self.allkeys[indexPath.row];
    if ([cell.label.text isEqualToString:@"Super Stars"]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"celebrity.jpg"]];
    } else if ([cell.label.text isEqualToString:@"That's so 90s"]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"90s.jpg"]];
    } else if ([cell.label.text isEqualToString:@"Hey Mr. DJ"]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dj.jpg"]];
    } else if ([cell.label.text isEqualToString:@"Icons"]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icons.jpg"]];
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"animal.jpeg"]];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(300, 300);
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


@end

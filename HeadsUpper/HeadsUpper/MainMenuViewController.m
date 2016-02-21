//
//  MainMenuViewController.m
//  HeadsUpper
//
//  Created by Justine Kay on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameViewController.h"
#import "TopicCollectionViewCell.h"
#import "APIManager.h"

@interface MainMenuViewController ()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *topics;

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TopicCollectionViewCell"];
    
    [self fetchTopicsData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (void) fetchTopicsData
{
    [APIManager getTopicData:^(NSArray *data) {
        
        self.topics = data;
    }];
    
}


#pragma mark - UICollectionView datasource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.topics.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopicCollectionViewCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Title";
    
    return cell;
}

#pragma mark - UICollectionView delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GameViewController *gameVC = [storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    
    [self presentViewController:gameVC animated:YES completion:nil];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark – UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *searchTerm = self.searches[indexPath.section];
//    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
//
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35;
    
    CGSize cellSize = CGSizeMake(100, 100);
    
    return cellSize;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(150, 20, 50, 20);
}

@end

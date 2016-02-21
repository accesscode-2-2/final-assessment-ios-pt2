//
//  GameCategoriesTableViewController.m
//  HeadsUpper
//
//  Created by Jackie Meggesto on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GameCategoriesTableViewController.h"
#import "GameCategoryTableViewCell.h"

@interface GameCategoriesTableViewController ()



@property (nonatomic) NSMutableDictionary* gameCategories;

@end

@implementation GameCategoriesTableViewController

- (void)viewDidLoad {
    

 
    
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Main Menu"];
    [self setUpDataSource];
    
}

    


#pragma mark - Table view data source

-(void)setUpDataSource
{
    self.gameCategories = [[NSMutableDictionary alloc]init];
    
    [self.gameCategories setObject:@[@"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"] forKey:@"Superstars"];
    [self.gameCategories setObject:@[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"] forKey:@"That's So 90's"];
    [self.gameCategories setObject:@[@"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" \n MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Someboyd To Love\" \n Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" \n Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" \n Gloria Gaynor", @"\"Come and Get it\" \n Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" \n R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" \n Vanessa Carlton", @"\"What a Wonderful World\" \n Louis Armstrong", @"\"We Belong Together\" \n Mariah Carey", @"\"(I Can't Get No) Satisfaction\""] forKey:@"Hey Mr. DJ"];
    [self.gameCategories setObject:@[@"Colin Farrell", @"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"] forKey:@"Icons"];
    [self.gameCategories setObject:@[@"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"] forKey:@"Animals"];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete implementation, return the number of rows
    return [self.gameCategories allKeys].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCategory" forIndexPath:indexPath];
    
    
    cell.categoryLabel.text = [self.gameCategories allKeys][indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    GameViewController* gvc = [self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    
    NSArray* keys = [self.gameCategories allKeys];
    NSMutableArray* arrayForGVC = [[NSMutableArray alloc]initWithArray:[self.gameCategories objectForKey:keys[indexPath.row]]];
    gvc.gameDataArray = arrayForGVC;
    
    [self.navigationController pushViewController:gvc animated:YES];
    
}



@end

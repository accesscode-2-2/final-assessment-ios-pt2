//
//  ViewController.m
//  HeadsUpper
//
//  Created by Michael Kavouras on 2/17/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "PlayViewController.h"
@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>


@property (nonatomic) NSDictionary *themes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"Heads Up";


    self.themes = @{
                                @"Superstars" : @[
                                        @"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"],
                                
                                @"That's so 90s" : @[
                                        @"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"],
                                
                                @"Hey Mr. DJ" : @[
                                        @"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Somebody To Love\" Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" Gloria Gaynor", @"\"Come and Get it\" Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" Vanessa Carlton", @"\"What a Wonderful World\" Louis Armstrong", @"\"We Belong Together\" Mariah Carey", @"\"(I Can't Get No) Satisfaction\""],
                                
                                @"Icons" : @[
                                        @"Colin Farrell", @"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"],
                                
                                @"Animals Gone Wild" : @[
                                        @"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"]
                                
                                };
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = [self.themes allKeys];

    return keys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSArray *keys = [self.themes allKeys];

    cell.textLabel.text = (NSString *)keys[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"Cream"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayViewController *detailVC = (PlayViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    
    NSArray *nameValues = [self.themes allKeys];
    detailVC.name = nameValues[indexPath.row];
    
    NSArray *nameValue = [self.themes allValues];
    detailVC.nameValue = nameValue[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSString *)objectForIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *keys = [self.themes allKeys];
    NSString *key = [keys objectAtIndex:indexPath.row];
    NSArray *values = [self.themes objectForKey:key];
    return values[indexPath.row];
    
}


@end

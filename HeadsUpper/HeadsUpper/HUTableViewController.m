//
//  HUTableViewController.m
//  HeadsUpper
//
//  Created by Felicia Weathers on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "HUTableViewController.h"
#import "HUGameViewController.h"
#import "HUData.h"

@interface HUTableViewController ()

@property (nonatomic)NSMutableArray *topics;

@end
@implementation HUTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Topics";
    
    [self.tableView reloadData];
    
    HUData *superstars = [[HUData alloc]init];
    
    superstars.topic = @"Superstars";
    superstars.clues = @[@"Janet Jackson",
                         @"Leighton Meester",
                         @"Willow Smith",
                         @"Matt Lauer",
                         @"Josh Duhamel",
                         @"Sharon Osbourne",
                         @"Spencer Pratt",
                         @"Demi Moore",
                         @"Whitney Houston",
                         @"Nicole Kidman",
                         @"Miley Cyrus",
                         @"Victoria Beckham",
                         @"LeAnn Rimes",
                         @"Dakota Fanning",
                         @"Dr. Seuss",
                         @"Ryan Phillippe",
                         @"Steve Carell",
                         @"Chris Rock",
                         @"Collin Ferell",
                         @"Drake",
                         @"Rachel McAdams",
                         @"Maya Rudolph",
                         @"Nelly Furtado",
                         @"Barbara Walters",
                         @"Alyson Hannigan",
                         @"Ashley Olsen",
                         @"Joseph Gordon-Levitt",
                         @"Kate Middleton",
                         @"Tom Hanks",
                         @"Clay Aiken",
                         @"Channing Tatum"];
    
    HUData *thatsSo90s = [[HUData alloc]init];
    
    thatsSo90s.topic = @"That's so 90s";
    thatsSo90s.clues = @[@"El Niño",
                         @"Viagra",
                         @"Animaniacs",
                         @"League of their Own",
                         @"Happy Gilmore",
                         @"Nick Carter",
                         @"My Heart Will Go On",
                         @"I Know What You Did Last Summer",
                         @"Can You Feel The Love Tonight",
                         @"The Macarana",
                         @"Light-up Sneakers",
                         @"Boy Meets World",
                         @"Baby Got Back",
                         @"Smells Like Teen Spirit",
                         @"Super Soakers",
                         @"7th Heaven",
                         @"Garth Brooks",
                         @"Floppy Discs",
                         @"Kramer",
                         @"Blink 182",
                         @"Surge",
                         @"Mighty Ducks",
                         @"Lamb Chop",
                         @"The Baseball Strike",
                         @"Macaulay Culkin",
                         @"Chain wallets",
                         @"Martin Lawrence",
                         @"Heather Locklear",
                         @"90210",
                         @"Clueless"];
    
    HUData *heyDJ = [[HUData alloc]init];
    
    heyDJ.topic = @"Hey Mr. DJ";
    heyDJ.clues = @[@"'Girl On Fire' Alicia Keys",
                    @"'U Can't Touch This' MC Hammer",
                    @"'Hello' Lionel Richie",
                    @"'Dark Horse' Katy Perry",
                    @"'Somebody To Love' Queen",
                    @"'No Scrubs' TLC",
                    @"'Happy' Pharrell Williams",
                    @"'Piano Man' Billy Joel",
                    @"'Blurred Lines' Robin Thicke",
                    @"'Fantasy' Mariah Carey",
                    @"'I Will Survive' Gloria Gaynor",
                    @"'Come and Get it' Selena Gomez",
                    @"'Halo' Beyonce",
                    @"'I Believe I Can Fly' R.Kelly",
                    @"'The Sign' Ace of Base",
                    @"'Diamonds' Rihanna",
                    @"'A Thousand Miles' Vanessa Carlton",
                    @"'What a Wonderful World' Louis Armstrong",
                    @"'We Belong Together' Mariah Carey",
                    @"'(I Can't Get No) Satisfaction' The Rolling Stones",
                    @"'I'd Do Anything For Love' Meat Loaf",
                    @"'Brown Eyed Girl' Van Morrison",
                    @"'Beat It' Michael Jackson",
                    @"'What Makes You Beautiful' One Direction",
                    @"'PYT' Michael Jackson",
                    @"'Respect' Aretha Franklin",
                    @"'MMM Bop' Hanson",
                    @"'All About that Bass' Meghan Trainor",
                    @"'Royals' Lorde",
                    @"'Love You Like A Love Song' Selena Gomez & the Scene"];
    
    HUData *famousPeople = [[HUData alloc]init];
    
    famousPeople.topic = @"Icons, Legends, & Stars";
    famousPeople.clues = @[@"Colin Farrell",
                           @"Mozart",
                           @"Billy Joel",
                           @"Judy Garland",
                           @"Napoleon Bonaparte",
                           @"Queen Elizabeth II",
                           @"Fred Armisen",
                           @"Henry Ford",
                           @"Jon Lovitz",
                           @"Julia Child",
                           @"Catherine the Great",
                           @"Magic Johnson",
                           @"Uma Thurman",
                           @"Orson Welles",
                           @"Kathy Bates",
                           @"George Orwell",
                           @"Billy Crystal",
                           @"Farrah Fawcett",
                           @"Gary Busey",
                           @"Chris Farley",
                           @"Tom Selleck",
                           @"Alexander the Great",
                           @"Ricky Gervais",
                           @"Tracey Ullman",
                           @"Bette Davis",
                           @"Jeremy Irons",
                           @"Chaka Khan",
                           @"Oscar Wilde",
                           @"Dan Aykroyd",
                           @"Margaret Thatcher",
                           @"Carol Burnett",
                           @"Patrick Stewert"];
    
    self.categoryTopics = @[superstars, thatsSo90s, heyDJ, famousPeople];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:1 alpha:1]];
    }
    else [cell setBackgroundColor:[UIColor colorWithRed:.8 green:1 blue:.8 alpha:1]];

    
    HUData *categoryTopics = self.categoryTopics[indexPath.row];
    cell.textLabel.text = categoryTopics.topic;
    
    cell.detailTextLabel.text = categoryTopics.clues;
    
    NSLog(@"%@", categoryTopics.topic);
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryTopics.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    HUData *categoryTopic = self.categoryTopics[indexPath.row];
    
    HUGameViewController *vc = segue.destinationViewController;
    vc.data = categoryTopic;
    
}

@end

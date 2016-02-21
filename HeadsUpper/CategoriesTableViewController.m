//
//  CategoriesTableViewController.m
//  HeadsUpper
//
//  Created by Jamaal Sedayao on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "CategoriesTableViewController.h"
#import "GameplayViewController.h"

@interface CategoriesTableViewController ()

@end

@implementation CategoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    
    self.navigationController.navigationBar.topItem.title = @"Choose A Category, buddy!";
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
    return self.categoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoriesIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.categoryArray[indexPath.row];
    
    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    GameplayViewController *destinationViewController = [segue destinationViewController];
    
    destinationViewController.categoryPlayed = self.categoryArray[indexPath.row];
    
    //NSDictionary *thisDict = self.categoryArray[indexPath.row];
    
    NSString *key = self.categoryArray[indexPath.row];
    
    destinationViewController.categoryArray = [self.categories valueForKey:key];

   // destinationViewController.categoryPlayed = self.categoryArray
    
    
    // Pass the selected object to the new view controller.
}


//Data

- (void)initializeData {
    
    self.superstarsArray = @[@"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Drake", @"Rachel McAdams", @"Maya Rudolph"];
    self.ninetiesArray = @[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"];
    self.musicArray = @[@"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Somebody To Love\" Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" Gloria Gaynor", @"\"Come and Get it\" Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" Vanessa Carlton", @"\"What a Wonderful World\" Louis Armstrong", @"\"We Belong Together\" Mariah Carey", @"\"(I Can't Get No) Satisfaction\""];
    self.iconsArray = @[@"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"];
    self.animalsArray = @[@"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"];
    self.c4qStudentsArray = @[@"Artur Lan",
                         @"Ayuna Vogel",
                         @"Bereket Ghebremedhin",
                         @"Brian Blanco",
                         @"Charles H Kang",
                         @"Chris David",
                         @"Christella Dolmo",
                         @"Christian Maldonado",
                         @"Daaaaaammmmmmnnnnn Daniel",
                         @"Derek Netto",
                         @"Diana Elezaj",
                         @"Elber Carneiro",
                         @"Eric Sanchez",
                         @"Eric Sze",
                         @"Felicia Weathers",
                         @"Henna Ahmed",
                         @"Jackie Meggesto",
                         @"Jamaal Sedayao",
                         @"Jason Wang",
                         @"Jovanny Espinal",
                         @"Justine Gartner",
                         @"Kaira Villanueva",
                         @"Kaisha Jones",
                         @"Krishna Picart",
                         @"Lauren Caponong",
                         @"Mesfin Bekele Mekonnen",
                         @"Natalia Estrella",
                         @"Shena Yoshida",
                         @"Umar Mahmud",
                         @"Varindra Hart",
                         @"Xiulan Shi",
                         @"Zoufishan Mehdi"];
    
    //self.superstarsDict = @{@"Superstars":self.superstarsArray};
    
    self.categories = @{@"Superstars":self.superstarsArray,
                        @"That's So 90's!":self.ninetiesArray,
                        @"Hey Mr. DJ!":self.musicArray,
                        @"Icons":self.iconsArray,
                        @"Crazy Animals!":self.animalsArray,
                        @"C4Q Students":self.c4qStudentsArray};
    
    
    self.categoryArray = [self.categories allKeys];
    
}

@end

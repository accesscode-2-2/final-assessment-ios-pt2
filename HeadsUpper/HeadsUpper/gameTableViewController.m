//
//  gameTableViewController.m
//  HeadsUpper
//
//  Created by Umar on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "gameTableViewController.h"
#import "detailViewController.h"

@interface gameTableViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>


@property (nonatomic) NSMutableDictionary *items;
@property (nonatomic) NSArray *superstars;
@property (nonatomic) NSArray *ninties;
@property (nonatomic) NSArray *dj;
@property (nonatomic) NSArray *icons;
@property (nonatomic) NSArray *animals;

@end

@implementation gameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.items = [NSMutableDictionary dictionary];
    
    self.superstars = @[@"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"];
    self.ninties = @[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"];
    self.dj = @[@"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Someboyd To Love\" Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" Gloria Gaynor", @"\"Come and Get it\" Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" Vanessa Carlton", @"\"What a Wonderful World\" Louis Armstrong", @"\"We Belong Together\" Mariah Carey", @"\"(I Can't Get No) Satisfaction\""];
    self.icons = @[@"Colin Farrell", @"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"];
    self.animals = @[@"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"];
    
    [self.items setObject: self.superstars forKey:@"Superstars"];
    
    [self.items setObject: self.ninties forKey: @"That's so 90s"];
    
    [self.items setObject: self.dj forKey:  @"Hey Mr. DJ"];
    
    [self.items setObject: self.icons forKey: @"Icons"];
    
    [self.items setObject: self.animals forKey:@"Animals Gone Wild"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated{
//    if([timer isValid])
//    {
//        
//        [timer invalidate];
//        timer=nil;
//        
//        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(CalcoloMediadiLaurea:) userInfo:nil repeats:YES];
//        
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    NSArray *keys = [self.items allKeys];

    return keys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSArray *keys = [self.items allKeys];
    cell.textLabel.text = [keys objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *value = cell.textLabel.text;
    
//    NSString *arrayItem = [self objectForIndexPath:indexPath];
    
    detailViewController *vc = segue.destinationViewController;
    
    vc.holdingArray = [self.items objectForKey:value];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  OptionsTableViewController.m
//  HeadsUpper
//
//  Created by Natalia Estrella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "OptionsTableViewController.h"
#import "OptionsManager.h"

@interface OptionsTableViewController ()


@end

@implementation OptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OptionsManager *planetCategory = [[OptionsManager alloc] init];
    
    planetCategory.categoryName = @"Superstars";
    planetCategory.categoryOptions = @[@"Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"];
    
    
    OptionsManager *treatCategory = [[OptionsManager alloc] init];
    
    treatCategory.categoryName = @"That's so 90s";
    treatCategory.categoryOptions = @[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"];
    
    
    OptionsManager *carsCategory = [[OptionsManager alloc] init];
    
    carsCategory.categoryName = @"Hey Mr. DJ";
    carsCategory.categoryOptions = @[@"\"Girl On Fire\" Alicia Keys",
                                     @"\"U Can't Touch This\" MC Hammer",
                                     @"\"Hello\" Lionel Richie",
                                     @"\"Dark Horse\" Katy Perry",
                                     @"\"Someboyd To Love\" Queen",
                                     @"\"No Scrubs\" TLC",
                                     @"\"Happy\" Pharrell Williams",
                                     @"\"Piano Man\" Billy Joel",
                                     @"\"Blurred Lines\" Robin Thicke",
                                     @"\"Fantasy\" Mariah Carey",
                                     @"\"I Will Survive\" Gloria Gaynor",
                                     @"\"Come and Get it\" Selena Gomez",
                                     @"\"Halo\" Beyonce",
                                     @"\"I Believe I Can Fly\" R.Kelly",
                                     @"\"The Sign\" Ace of Base",
                                     @"\"Diamonds\" Rihanna",
                                     @"\"A Thousand Miles\" Vanessa Carlton",
                                     @"\"What a Wonderful World\" Louis Armstrong",
                                     @"\"We Belong Together\" Mariah Carey",
                                     @"\"(I Can't Get No) Satisfaction\""];
    
    //Array of CQCategory Objects
    self.categoryObjects = @[planetCategory, treatCategory, carsCategory];
    [self.tableView reloadData];

    

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headUppersMa" forIndexPath:indexPath];
    
    OptionsManager *categoryObject = self.categoryObjects[indexPath.row];
    cell.textLabel.text = categoryObject.categoryName;
    
    
    return cell;
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

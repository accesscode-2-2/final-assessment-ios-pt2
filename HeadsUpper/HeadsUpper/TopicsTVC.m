//
//  TopicsTVC.m
//  HeadsUpper
//
//  Created by Christella on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "TopicsTVC.h"
#import "TopicsDetailVC.h"
#import "Topics.h"
#import "TopicSelectionTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface TopicsTVC ()



@property (nonatomic) NSArray * topics;

@property(nonatomic, strong) AVAudioPlayer *backgroundMusic;

@end

@implementation TopicsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopicsData];

}


- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
    [self playMusic];
    
}

-(void) playMusic {
    NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"jackpot loop"
                                               withExtension:@"wav"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                  error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic play];
    
}

-(void) playNewGameSound {
    NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"10 New Game Sound"
                                               withExtension:@"wav"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile
                                                                  error:nil];
    self.backgroundMusic.numberOfLoops = 0;
    [self.backgroundMusic play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - The Data


-(void) setupTopicsData {
    
    Topics *superStars = [[Topics alloc]init];
    Topics *thatsSoNineties = [[Topics alloc]init];
    Topics *heyMrDJ = [[Topics alloc]init];
    Topics *icons = [[Topics alloc]init];
    Topics *animalsGoneWild = [[Topics alloc]init];

    superStars.topicName = @"Super Stars";
    superStars.topicClues = @[@"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"];

    thatsSoNineties.topicName = @"That's so 90s";
    thatsSoNineties.topicClues = @[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"];

    heyMrDJ.topicName = @"Hey Mr. DJ";
    heyMrDJ.topicClues = @[@"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Someboyd To Love\" Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" Gloria Gaynor", @"\"Come and Get it\" Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" Vanessa Carlton", @"\"What a Wonderful World\" Louis Armstrong", @"\"We Belong Together\" Mariah Carey", @"\"(I Can't Get No) Satisfaction\""];

    icons.topicName = @"Icons";
    icons.topicClues = @[@"Colin Farrell", @"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"];

    animalsGoneWild.topicName = @"Animals Gone Wild";
    animalsGoneWild.topicClues = @[@"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"];
    
    self.topics = @[superStars, thatsSoNineties, heyMrDJ, icons, animalsGoneWild];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicsCell" forIndexPath:indexPath];
    
    Topics *topics = [self.topics objectAtIndex: indexPath.row];
    cell.topicLbl.text = topics.topicName;
    
    cell.topicsImg.image = [UIImage imageNamed:[topics.topicName lowercaseString]];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.backgroundMusic stop];
    [self playNewGameSound];
    
    TopicsDetailVC *topicsClue = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    Topics *newCategory = [self.topics objectAtIndex:indexPath.row];
    
    topicsClue.clues = newCategory;
    
}

@end

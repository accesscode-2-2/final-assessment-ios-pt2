//
//  CategoryAndClueSetup.m
//  HeadsUpper
//
//  Created by Mesfin Bekele Mekonnen on 2/21/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "CategoryAndClueSetup.h"

@implementation CategoryAndClueSetup


-(instancetype)initCategories {
    
    if (self = [super init]) {
        self.gameCategories = [NSMutableArray new];
        self.gameCategories = [self setup];
        return self;
    }
    
    return nil;
}

-(HUGameCategory *)createHUGameCategoryFor:(NSString *)category andClues:(NSMutableArray<NSString *> *)clues {
    
    HUGameCategory *gameCategory = [[HUGameCategory alloc] initWithName:category andClues:clues];
    return gameCategory;
}

-(NSMutableArray<HUGameCategory *> *)setup {
    
    NSMutableArray<HUGameCategory *> *gameCategoriesArray = [NSMutableArray new];
    
    NSMutableArray *superstarsClues = [[NSMutableArray alloc] initWithArray:@[@"Janet Jackson", @"Leighton Meester", @"Willow Smith", @"Matt Lauer", @"Josh Duhamel", @"Sharon Osbourne", @"Spencer Pratt", @"Demi Moore", @"Whitney Houston", @"Nicole Kidman", @"Miley Cyrus", @"Victoria Beckham", @"LeAnn Rimes", @"Dakota Fanning", @"Dr. Seuss", @"Ryan Phillippe", @"Steve Carell", @"Chris Rock", @"Collin Ferell", @"Drake", @"Rachel McAdams", @"Maya Rudolph"]];
    
    
       HUGameCategory *superstars = [self createHUGameCategoryFor:@"Superstars" andClues:superstarsClues];
    
    [gameCategoriesArray addObject:superstars];
    
    NSMutableArray *so90sClues = [[NSMutableArray alloc] initWithArray:@[@"El Niño", @"Viagra", @"Animaniacs", @"League of their Own", @"Happy Gilmore", @"Nick Carter", @"My Heart Will Go On", @"I Know What You Did Last Summer", @"Can You Feel The Love Tonight", @"The Macarana", @"Light-up Sneakers", @"Boy Meets World", @"Baby Got Back", @"Smells Like Teen Spirit", @"Super Soakers", @"7th Heaven", @"Garth Brooks", @"Floppy Discs", @"Kramer", @"Blink 182", @"Surge"]];
    
    HUGameCategory *so90s = [self createHUGameCategoryFor:@"That's so 90's" andClues:so90sClues];
    
    [gameCategoriesArray addObject:so90s];
    
    NSMutableArray *heyMrDJclues = [[NSMutableArray alloc] initWithArray:@[@"\"Girl On Fire\" Alicia Keys", @"\"U Can't Touch This\" MC Hammer", @"\"Hello\" Lionel Richie", @"\"Dark Horse\" Katy Perry", @"\"Someboyd To Love\" Queen", @"\"No Scrubs\" TLC", @"\"Happy\" Pharrell Williams", @"\"Piano Man\" Billy Joel", @"\"Blurred Lines\" Robin Thicke", @"\"Fantasy\" Mariah Carey", @"\"I Will Survive\" Gloria Gaynor", @"\"Come and Get it\" Selena Gomez", @"\"Halo\" Beyonce", @"\"I Believe I Can Fly\" R.Kelly", @"\"The Sign\" Ace of Base", @"\"Diamonds\" Rihanna", @"\"A Thousand Miles\" Vanessa Carlton", @"\"What a Wonderful World\" Louis Armstrong", @"\"We Belong Together\" Mariah Carey", @"\"(I Can't Get No) Satisfaction\""]];
    
    HUGameCategory *heyMrDJ = [self createHUGameCategoryFor:@"Hey Mr. DJ!" andClues:heyMrDJclues];
    
    [gameCategoriesArray addObject:heyMrDJ];
    
    
    NSMutableArray *iconsClues = [[NSMutableArray alloc] initWithArray:@[@"Colin Farrell", @"Mozart", @"Billy Joel", @"Judy Garland", @"Napoleon Bonaparte", @"Queen Elizabeth II", @"Fred Armisen", @"Henry Ford", @"Jon Lovitz", @"Julia Child", @"Catherine the Great", @"Magic Johnson", @"Uma Thurman", @"Orson Welles", @"Kathy Bates", @"George Orwell", @"Billy Crystal", @"Farrah Fawcett", @"Gary Busey", @"Chris Farley", @"Tom Selleck", @"Alexander the Great"]];
 
    HUGameCategory *icons = [self createHUGameCategoryFor:@"Icons" andClues:iconsClues];
    
    [gameCategoriesArray addObject:icons];
    
    NSMutableArray *animalsGoneWildClues = [[NSMutableArray alloc] initWithArray:@[@"Chipmunk", @"Dragon", @"Wasp", @"Snake", @"Jellyfish", @"Emu", @"Boar", @"Crocodile", @"Shrimp", @"Lemur", @"Caterpillar", @"Sea Urchain", @"Dolphin ", @"Camel", @"Viper", @"Fox", @"Tuna", @"Baboon", @"Chinchilla", @"Human", @"Crawfish", @"Cricket", @"Frog", @"Tiger", @"Guinea Pig", @"Gnat", @"Killer Whale", @"Coral", @"T-Rex", @"Oyster"]];
    
    HUGameCategory *animalsGoneWild = [self createHUGameCategoryFor:@"Animals Gone wild" andClues:animalsGoneWildClues];
    
    [gameCategoriesArray addObject:animalsGoneWild];
    
    
    return  gameCategoriesArray;
}

@end

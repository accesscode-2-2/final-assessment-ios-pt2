//
//  GameData.swift
//  HeadsUpper
//
//  Created by Lauren Caponong on 2/21/16.
//  Copyright © 2016 Lauren Caponong. All rights reserved.
//

import UIKit

class GameData {
    
    let topicsAndValues: [String:[String]]
    
    init(){
        let superstarsArray = ["Janet Jackson", "Leighton Meester", "Willow Smith", "Matt Lauer", "Josh Duhamel", "Sharon Osbourne", "Spencer Pratt", "Demi Moore", "Whitney Houston", "Nicole Kidman", "Miley Cyrus", "Victoria Beckham", "LeAnn Rimes", "Dakota Fanning", "Dr. Seuss", "Ryan Phillippe", "Steve Carell", "Chris Rock", "Collin Ferell", "Drake", "Rachel McAdams", "Maya Rudolph", "Jimmy Fallon", "Killer Mike", "Ewan McGregor", "Bernie Sanders"]
        
        let thatsSo90sArray = ["El Niño", "Viagra", "Animaniacs", "League of their Own", "Happy Gilmore", "Nick Carter", "My Heart Will Go On", "I Know What You Did Last Summer", "Can You Feel The Love Tonight", "The Macarana", "Light-up Sneakers", "Boy Meets World", "Baby Got Back", "Smells Like Teen Spirit", "Super Soakers", "7th Heaven", "Garth Brooks", "Floppy Discs", "Kramer", "Blink 182", "Surge"]
        
        let heyMrDJArray = ["\"Girl On Fire\" Alicia Keys", "\"U Can't Touch This\" MC Hammer", "\"Hello\" Lionel Richie", "\"Dark Horse\" Katy Perry", "\"Someboyd To Love\" Queen", "\"No Scrubs\" TLC", "\"Happy\" Pharrell Williams", "\"Piano Man\" Billy Joel", "\"Blurred Lines\" Robin Thicke", "\"Fantasy\" Mariah Carey", "\"I Will Survive\" Gloria Gaynor", "\"Come and Get it\" Selena Gomez", "\"Halo\" Beyonce", "\"I Believe I Can Fly\" R.Kelly", "\"The Sign\" Ace of Base", "\"Diamonds\" Rihanna", "\"A Thousand Miles\" Vanessa Carlton", "\"What a Wonderful World\" Louis Armstrong", "\"We Belong Together\" Mariah Carey", "\"(I Can't Get No) Satisfaction\""]
        
        let iconsArray = ["Colin Farrell", "Mozart", "Billy Joel", "Judy Garland", "Napoleon Bonaparte", "Queen Elizabeth II", "Fred Armisen", "Henry Ford", "Jon Lovitz", "Julia Child", "Catherine the Great", "Magic Johnson", "Uma Thurman", "Orson Welles", "Kathy Bates", "George Orwell", "Billy Crystal", "Farrah Fawcett", "Gary Busey", "Chris Farley", "Tom Selleck", "Alexander the Great"]
        
        let animalsGoneWildArray = ["Chipmunk", "Dragon", "Wasp", "Snake", "Jellyfish", "Emu", "Boar", "Crocodile", "Shrimp", "Lemur", "Caterpillar", "Sea Urchain", "Dolphin ", "Camel", "Viper", "Fox", "Tuna", "Baboon", "Chinchilla", "Human", "Crawfish", "Cricket", "Frog", "Tiger", "Guinea Pig", "Gnat", "Killer Whale", "Coral", "T-Rex", "Oyster"]
        
        topicsAndValues =
            ["Superstars": superstarsArray,
                "That's So 90s": thatsSo90sArray,
                "Hey Mr. DJ": heyMrDJArray,
                "Icons": iconsArray,
                "Animals Gone Wild": animalsGoneWildArray]
    
    }

}
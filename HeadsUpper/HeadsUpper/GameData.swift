//
//  GameData.swift
//  HeadsUpper
//
//  Created by Jovanny Espinal on 2/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

class GameData {
    let topicsAndAnswers: [String:[String]]
    
    init(){
        let superstarsArray = ["Janet Jackson", "Leighton Meester", "Willow Smith", "Matt Lauer", "Josh Duhamel", "Sharon Osbourne", "Spencer Pratt", "Demi Moore", "Whitney Houston", "Nicole Kidman", "Miley Cyrus", "Victoria Beckham", "LeAnn Rimes", "Dakota Fanning", "Dr. Seuss", "Ryan Phillippe", "Steve Carell", "Chris Rock", "Collin Ferell", "Drake", "Rachel McAdams", "Maya Rudolph"]
        
        let thatsSo90sArray = ["El Niño", "Viagra", "Animaniacs", "League of their Own", "Happy Gilmore", "Nick Carter", "My Heart Will Go On", "I Know What You Did Last Summer", "Can You Feel The Love Tonight", "The Macarana", "Light-up Sneakers", "Boy Meets World", "Baby Got Back", "Smells Like Teen Spirit", "Super Soakers", "7th Heaven", "Garth Brooks", "Floppy Discs", "Kramer", "Blink 182", "Surge"]
        
        let heyMrDJ = ["\"Girl On Fire\" Alicia Keys", "\"U Can't Touch This\" MC Hammer", "\"Hello\" Lionel Richie", "\"Dark Horse\" Katy Perry", "\"Someboyd To Love\" Queen", "\"No Scrubs\" TLC", "\"Happy\" Pharrell Williams", "\"Piano Man\" Billy Joel", "\"Blurred Lines\" Robin Thicke", "\"Fantasy\" Mariah Carey", "\"I Will Survive\" Gloria Gaynor", "\"Come and Get it\" Selena Gomez", "\"Halo\" Beyonce", "\"I Believe I Can Fly\" R.Kelly", "\"The Sign\" Ace of Base", "\"Diamonds\" Rihanna", "\"A Thousand Miles\" Vanessa Carlton", "\"What a Wonderful World\" Louis Armstrong", "\"We Belong Together\" Mariah Carey", "\"(I Can't Get No) Satisfaction\""]
        
        let icons = ["Colin Farrell", "Mozart", "Billy Joel", "Judy Garland", "Napoleon Bonaparte", "Queen Elizabeth II", "Fred Armisen", "Henry Ford", "Jon Lovitz", "Julia Child", "Catherine the Great", "Magic Johnson", "Uma Thurman", "Orson Welles", "Kathy Bates", "George Orwell", "Billy Crystal", "Farrah Fawcett", "Gary Busey", "Chris Farley", "Tom Selleck", "Alexander the Great"]
        
        let animalsGoneWild = ["Chipmunk", "Dragon", "Wasp", "Snake", "Jellyfish", "Emu", "Boar", "Crocodile", "Shrimp", "Lemur", "Caterpillar", "Sea Urchain", "Dolphin ", "Camel", "Viper", "Fox", "Tuna", "Baboon", "Chinchilla", "Human", "Crawfish", "Cricket", "Frog", "Tiger", "Guinea Pig", "Gnat", "Killer Whale", "Coral", "T-Rex", "Oyster"]

        topicsAndAnswers =
            ["Superstars": superstarsArray,
             "That's So 90s": thatsSo90sArray,
             "Hey Mr. DJ": heyMrDJ,
             "Icons": icons,
             "Animals Gone Wild": animalsGoneWild]
    }
}

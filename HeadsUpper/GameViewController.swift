//
//  GameViewController.swift
//  HeadsUpper
//
//  Created by Lauren Caponong on 2/21/16.
//  Copyright © 2016 Lauren Caponong. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var thingToGuessLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var count = 5
    var topicName = String()
    var trimmedTopicName = String()
    var swipeIndex = 0
    var timesSwipedRight = 0
    var timesSwipedLeft = 0


    override func viewDidLoad() {
        
        print("Second view controller: the topic name is \(topicName)")
        
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)

        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        navigationItem.title = topicName
    }
    
    
    func showTimer() {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:("updateTimer"), userInfo: nil, repeats: true)
    }
    
    
    func updateTimer() {
        
        if (count > -1) {
            timerLabel.text = String(count--)
        }
        
        if (count == 0) {
            [gameOver()]
        }
    }
    
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                
                swipeIndex++
                if swipeIndex < 0 {
                    print("no more")
                }
                
                let title = topicName as? String
                thingToGuessLabel.text = (Superstars["items"] as! [String])[swipeIndex]
                view.layer.backgroundColor = UIColor.greenColor().CGColor
                
                timesSwipedRight++
                
            case UISwipeGestureRecognizerDirection.Down:
                showTimer()
                swipeIndex++
                if swipeIndex < 0 {
                    print("no more")
                }
                let key: String = "title"
                let title = Superstars["title"] as? String
                thingToGuessLabel.text = (Superstars["items"] as! [String])[swipeIndex]
                
            case UISwipeGestureRecognizerDirection.Left:
                swipeIndex++
                if swipeIndex < 0 {
                    print("no more")
                }
                thingToGuessLabel.text = (Superstars["items"] as! [String])[swipeIndex]
                view.layer.backgroundColor = UIColor.redColor().CGColor
                timesSwipedLeft++
                
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped up")
                
            default:
                break
            }
            
            
        }
    }
    
    
    
    func gameOver() {
        
        let alertController = UIAlertController(title: "Game Over", message: "You got \(timesSwipedRight) correct and \(timesSwipedLeft) wrong.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Play again", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
//    
//
    let Superstars: [String: AnyObject] = [
        "title": "Superstars",
        "items": ["Janet Jackson", "Leighton Meester", "Willow Smith", "Matt Lauer", "Josh Duhamel", "Sharon Osbourne", "Spencer Pratt", "Demi Moore", "Whitney Houston", "Nicole Kidman", "Miley Cyrus", "Victoria Beckham", "LeAnn Rimes", "Dakota Fanning", "Dr. Seuss", "Ryan Phillippe", "Steve Carell", "Chris Rock", "Collin Ferell", "Drake", "Rachel McAdams", "Maya Rudolph", "Jimmy Fallon", "Killer Mike", "Ewan McGregor", "Bernie Sanders"]]
    
    
    let ThatsSo90s: [String: AnyObject] = [
        
        "title" : "That's So 90s",
        
        "items" : ["El Niño", "Viagra", "Animaniacs", "League of their Own", "Happy Gilmore", "Nick Carter", "My Heart Will Go On", "I Know What You Did Last Summer", "Can You Feel The Love Tonight", "The Macarana", "Light-up Sneakers", "Boy Meets World", "Baby Got Back", "Smells Like Teen Spirit", "Super Soakers", "7th Heaven", "Garth Brooks", "Floppy Discs", "Kramer", "Blink 182", "Surge", "Pogs", "Full House"]]
    
    let HeyMrDJ: [String: AnyObject] = [
        
        "title" : "Hey Mr. DJ",
        
        "items": ["\"Girl On Fire\" Alicia Keys", "\"U Can't Touch This\" MC Hammer", "\"Hello\" Lionel Richie", "\"Dark Horse\" Katy Perry", "\"Someboyd To Love\" Queen", "\"No Scrubs\" TLC", "\"Happy\" Pharrell Williams", "\"Piano Man\" Billy Joel", "\"Blurred Lines\" Robin Thicke", "\"Fantasy\" Mariah Carey", "\"I Will Survive\" Gloria Gaynor", "\"Come and Get it\" Selena Gomez", "\"Halo\" Beyonce", "\"I Believe I Can Fly\" R.Kelly", "\"The Sign\" Ace of Base", "\"Diamonds\" Rihanna", "\"A Thousand Miles\" Vanessa Carlton", "\"What a Wonderful World\" Louis Armstrong", "\"We Belong Together\" Mariah Carey", "\"(I Can't Get No) Satisfaction\""]]

    let Icons: [String: AnyObject] = [
        
        "title" : "Icons",
        
        "items": ["Colin Farrell", "Mozart", "Billy Joel", "Judy Garland", "Napoleon Bonaparte", "Queen Elizabeth II", "Fred Armisen", "Henry Ford", "Jon Lovitz", "Julia Child", "Catherine the Great", "Magic Johnson", "Uma Thurman", "Orson Welles", "Kathy Bates", "George Orwell", "Billy Crystal", "Farrah Fawcett", "Gary Busey", "Chris Farley", "Tom Selleck", "Alexander the Great"]]

    
    
    let AnimalsGoneWild: [String: AnyObject] = [
    
        "title" : "Animals Gone Wild",
        
        "items": ["Chipmunk", "Dragon", "Wasp", "Snake", "Jellyfish", "Emu", "Boar", "Crocodile", "Shrimp", "Lemur", "Caterpillar", "Sea Urchain", "Dolphin ", "Camel", "Viper", "Fox", "Tuna", "Baboon", "Chinchilla", "Human", "Crawfish", "Cricket", "Frog", "Tiger", "Guinea Pig", "Gnat", "Killer Whale", "Coral", "T-Rex", "Oyster"]]
    
//
//
//    
////    
//    let superstars = ["Janet Jackson", "Leighton Meester", "Willow Smith", "Matt Lauer", "Josh Duhamel", "Sharon Osbourne", "Spencer Pratt", "Demi Moore", "Whitney Houston", "Nicole Kidman", "Miley Cyrus", "Victoria Beckham", "LeAnn Rimes", "Dakota Fanning", "Dr. Seuss", "Ryan Phillippe", "Steve Carell", "Chris Rock", "Collin Ferell", "Drake", "Rachel McAdams", "Maya Rudolph"]
//    
//    let thatsSo90s = ["El Niño", "Viagra", "Animaniacs", "League of their Own", "Happy Gilmore", "Nick Carter", "My Heart Will Go On", "I Know What You Did Last Summer", "Can You Feel The Love Tonight", "The Macarana", "Light-up Sneakers", "Boy Meets World", "Baby Got Back", "Smells Like Teen Spirit", "Super Soakers", "7th Heaven", "Garth Brooks", "Floppy Discs", "Kramer", "Blink 182", "Surge"]
//    
//    let heyMrDJ = ["\"Girl On Fire\" Alicia Keys", "\"U Can't Touch This\" MC Hammer", "\"Hello\" Lionel Richie", "\"Dark Horse\" Katy Perry", "\"Someboyd To Love\" Queen", "\"No Scrubs\" TLC", "\"Happy\" Pharrell Williams", "\"Piano Man\" Billy Joel", "\"Blurred Lines\" Robin Thicke", "\"Fantasy\" Mariah Carey", "\"I Will Survive\" Gloria Gaynor", "\"Come and Get it\" Selena Gomez", "\"Halo\" Beyonce", "\"I Believe I Can Fly\" R.Kelly", "\"The Sign\" Ace of Base", "\"Diamonds\" Rihanna", "\"A Thousand Miles\" Vanessa Carlton", "\"What a Wonderful World\" Louis Armstrong", "\"We Belong Together\" Mariah Carey", "\"(I Can't Get No) Satisfaction\""]
//    
//    let icons = ["Colin Farrell", "Mozart", "Billy Joel", "Judy Garland", "Napoleon Bonaparte", "Queen Elizabeth II", "Fred Armisen", "Henry Ford", "Jon Lovitz", "Julia Child", "Catherine the Great", "Magic Johnson", "Uma Thurman", "Orson Welles", "Kathy Bates", "George Orwell", "Billy Crystal", "Farrah Fawcett", "Gary Busey", "Chris Farley", "Tom Selleck", "Alexander the Great"]
//    
//    let animalsGoneWild = ["Chipmunk", "Dragon", "Wasp", "Snake", "Jellyfish", "Emu", "Boar", "Crocodile", "Shrimp", "Lemur", "Caterpillar", "Sea Urchain", "Dolphin ", "Camel", "Viper", "Fox", "Tuna", "Baboon", "Chinchilla", "Human", "Crawfish", "Cricket", "Frog", "Tiger", "Guinea Pig", "Gnat", "Killer Whale", "Coral", "T-Rex", "Oyster"]
//    
//
    
    
    
    

}

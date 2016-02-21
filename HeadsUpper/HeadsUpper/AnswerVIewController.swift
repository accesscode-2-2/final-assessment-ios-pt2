//
//  AnswerVIewController.swift
//  HeadsUpper
//
//  Created by Jovanny Espinal on 2/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController
{
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    var timer: NSTimer?
    var count = 3
    var answers: [String] = []
    var didWin = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateLabels()
        
        addSwipeGestures()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
}


// MARK: Game State Functionalities
extension AnswerViewController
{
    func nextQuestion()
    {
        if !didWin {
            answers.removeFirst()
            
            checkForWin()
        }
        
        updateAnswerLabel()
    }
    
    func checkForWin()
    {
        didWin = answers.isEmpty
    }
    
    func checkForStatusOfPlayer()
    {
        if count == 0 {
            gameOver()
        } else if didWin {
            timer!.invalidate()
            
            updateLabels()
            
            displayAlert()
        } else {
            updateLabels()
        }
    }
}

// MARK: Timer Functionalities
extension AnswerViewController
{
    func startTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func countDown()
    {
        count -= 1
        checkForStatusOfPlayer()
    }
}

// MARK: Gesture Functionalities
extension AnswerViewController
{
    func addSwipeGestures()
    {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "correct")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "skip")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func correct()
    {
        nextQuestion()
        
        changeBackgroundColor(UIColor.greenColor())
    }
    
    func skip()
    {
        nextQuestion()
        
        changeBackgroundColor(UIColor.redColor())
    }
}

// MARK: UI Update Functionalities
extension AnswerViewController
{
    func updateLabels()
    {
        updateAnswerLabel()
        updateTimerLabel()
    }
    
    func updateTimerLabel()
    {
        if count == 0 || didWin {
            timerLabel.text = nil
        } else if !didWin {
            timerLabel.text = "\(count)"
        }

    }
    
    func updateAnswerLabel()
    {
        if didWin {
            answerLabel.text = "WINNER WINNER CHICKEN DINNER!"
        } else if count  == 0 {
            answerLabel.text = "WOMP WOMP! TRY AGAIN!"
        } else {
            answerLabel.text = answers.first
        }
    
    }
    
    func changeBackgroundColor(toColor: UIColor)
    {
        if didWin {
            self.view.backgroundColor = UIColor.greenColor()
        } else {
            UIView.animateWithDuration(0.55, animations: {
                self.view.backgroundColor = toColor
                self.view.backgroundColor = UIColor.whiteColor()
            })
        }
        
    }
    
    func gameOver()
    {
        self.view.backgroundColor = UIColor.redColor()
        
        timer!.invalidate()
        
        updateLabels()
        
        removeGestureRecognizers()
        
        displayAlert()
    }
    
    func removeGestureRecognizers()
    {
        if self.view.gestureRecognizers != nil {
            for gesture in self.view.gestureRecognizers! {
                if let recognizer = gesture as? UISwipeGestureRecognizer {
                    self.view.removeGestureRecognizer(recognizer)
                }
            }
        }
    }
    
    func displayAlert()
    {
        let alertController = UIAlertController(title: "Game Over", message: returnAlertMessage(), preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default) { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(defaultAction)

        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func returnAlertMessage() -> String
    {
        var alertMessage = ""
        
        if didWin {
            alertMessage = "Nailed it! Try a different topic!"
        } else if count == 0 {
            alertMessage = "Bummer! You lost. Try again!"
        }
        
        return alertMessage
    }
    
}

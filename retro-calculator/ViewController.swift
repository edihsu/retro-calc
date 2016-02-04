//
//  ViewController.swift
//  retro-calculator
//
//  Created by edward hsu on 2/2/16.
//  Copyright © 2016 Edward Hsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // making your own type
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    
    // calling on enum defined above, and can initially be empty.
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // location (path) of the sound file:
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        // audio player requires this be NSURL, a "special Apple Kit url"
        let soundURL = NSURL(fileURLWithPath: path!)
        
        
        // might have put a bad URL in, so it'll give an error "call can throw", so need to put in do {} try
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // btn is the button defined in calculator
    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        
        // btn.tag each number has a differen ttag
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run some math
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                // A user seelcted an operator, but then selected another opeator without first entering a number:
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            // This is the first time an operation has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}


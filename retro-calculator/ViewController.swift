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
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    
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
    
    @IBAction func numberPressed(btn: UIButton) {
        btnSound.play()
    }
    
    
}


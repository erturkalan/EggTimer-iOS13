//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    
    var secondsRemaining = 0

    var totalTime = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        secondsRemaining = 0
        progressBar.progress = 0.0
        titleLabel.text = hardness
        timer.invalidate()
    
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    
    @objc func updateTimer(){
        
        if  secondsRemaining < totalTime{
            secondsRemaining += 1
            progressBar.progress = Float(secondsRemaining)/Float(totalTime)
            
        } else if secondsRemaining == totalTime{
            timer.invalidate()
            progressBar.progress = Float(secondsRemaining)/Float(totalTime)
            titleLabel.text = "DONE!"
           
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player?.play()
            
        }
    }
}

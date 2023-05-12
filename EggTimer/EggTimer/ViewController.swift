//
//  ViewController.swift
//  EggTimer
//
//  Created by salo khizanishvili on 12.05.23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft" : 10, "Medium" : 15, "Hard" : 20]
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime = 0
    var hardness = ""
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var DoneLbl: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        hardness = sender.currentTitle!
        DoneLbl.text = "\(eggTimes[hardness]!) seconds"
        progressBar.progress = 1.0
        secondsRemaining = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        progressBar.progress -= 1.0/Float(totalTime)
        if secondsRemaining > 1 {
            DoneLbl.text = "\(secondsRemaining-1) seconds"
            secondsRemaining -= 1
        }
        else {
            timer.invalidate()
            DoneLbl.text = "\(hardness) egg is Done"
            progressBar.progress = 0.0
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

//
//  PlaySoundViewController.swift
//  VoiceRecorder
//
//  Created by Jermaine Lorenzo Goins on 1/11/18.
//  Copyright © 2018 Jermaine Lorenzo Goins. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // Wiring @IBOutlet to UIButton
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Created variable for recordedAudioURL
    var recordedAudioURL: URL!
    
    // Created variables for audio modification
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int{
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // Methods to performs action for voice modifier and stop button
    @IBAction func playSoundForButton(_ sender: UIButton){
        
        // Modifies sound file depending on what the user presses
        switch (ButtonType(rawValue: sender.tag)! ) {
            
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}

//
//  PlaySoundsViewController.swift
//  Read2Me
//
//  Created by Jermaine Lorenzo Goins on 1/19/18.
//  Copyright © 2018 Jermaine Lorenzo Goins. All rights reserved.
//

import Foundation
import UIKit

// Import class that is for audio recording
import AVFoundation

//MARK: Properties
class PlaySoundsViewController: UIViewController {
    
    //MARK: Global created variables for recordedTitleURL & recordedPageURL
    var recordedAudioURL: URL!
    
    //MARK: Audio variable created variable to modify audio files
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb, normal
    }
    
    // Record Screen
    @IBOutlet weak var navTitle: UINavigationItem!
    
    // Read Story
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    
    // Function that modifies audio files and uses switch statement to access appriopiate change
    @IBAction func playSoundForButton(_ sender: UIButton){
        
        // Uses switch statement on what the user pressed to change audio file
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
            
        default:
            playSound(rate: 1)
        }
        
        configureUI(.playing)
    }
    
    // Sets up audio for title and page section of apps
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read Story Scene preparation
        setupAudio()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Override function that configures UI when audio is not playing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    // ________________ List of Functions __________________
    // Conducts condition statement to test whether the app is playing or stopped and performs the appriopiate action
    func configUI(playing: Bool){
        
        if playing{
            
            snailButton.isEnabled = true
            rabbitButton.isEnabled = true
            chipmunkButton.isEnabled = true
            vaderButton.isEnabled = true
            echoButton.isEnabled = true
            reverbButton.isEnabled = true
            nextPageButton.isHidden = true
            pauseButton.isEnabled = true
        } else {
            
            snailButton.isHidden = true
            rabbitButton.isHidden = true
            chipmunkButton.isHidden = true
            vaderButton.isHidden = true
            echoButton.isHidden = true
            reverbButton.isHidden = true
            nextPageButton.isEnabled = true
            pauseButton.isHidden = false
        }
    }
}

    

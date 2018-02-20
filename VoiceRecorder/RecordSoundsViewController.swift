//
//  RecordSoundsViewController.swift
//  VoiceRecorder
//
//  Created by Jermaine Lorenzo Goins on 12/13/17.
//  Copyright © 2017 Jermaine Lorenzo Goins. All rights reserved.
//

import UIKit
// Import class for audio recording
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudioURL:URL!
    var recording: Bool!
    
    // Connected objects to main page
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disables stopRecordButton by default
        stopRecordButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear is called")
    }
    
    @IBAction func recordButton(_ sender: UIButton) {
        
        // Function that passes true that the app is recording and to follow the appropiate actions
        configUI(recording: true)
        
        // Inserted code that assigns final variable pathways and URL name to recorded audio so it can be called and manipulated at a later time.
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // Print the variable filePath to display what it is being named
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        
        // Function that passes false that the app is recording and to follow the appropiate actions
        configUI(recording: false)
        
        // Stops the audio recording and sets the setActive() to inactive
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        // Conditional statement testing if the recording was successful and if it was perform the performSegue() else print message to console
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }  else  {
            print("Recording was not successfull")
        }
        
    }
    
    // Prepares the Controller for PlaySoundViewController segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            //Set the recorded audio URL to be the URL coming in from the sender which is the performSegue function's parameter "audioRecorder.url"
            let recordedAudioURL = sender as! URL
            //Set the recordedAudioURL property in the PlaySoundsViewController. This is how the recording is being sent to the PlaySoundsVC.
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
        
    }
    
    // Declaring function for config
    func configUI(recording: Bool){
        
        if recording{
            recordButton.isEnabled = false
            stopRecordButton.isEnabled = true
            recordLabel.text = "Recording in Progress"
        } else {
            recordButton.isEnabled = true
            stopRecordButton.isEnabled = false
            recordLabel.text = "Tap to Record"
        }
    }
    
    
}

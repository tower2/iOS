//
//  ViewController.swift
//  Read2Me
//
//  Created by Jermaine Lorenzo Goins on 1/16/18.
//  Copyright © 2018 Jermaine Lorenzo Goins. All rights reserved.
//

import UIKit

// Import class that is for audio recording
import AVFoundation

//MARK: Properties
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: Variable preparing
    // Variable preparing app for recording story title and story content
    var audioRecorder: AVAudioRecorder!
    var recordedAudioURL: URL!
    var recording: Bool!
    var playing: Bool!
    var recordingTitle: Bool = true
    
    var UIPasteboardTypeListURL: NSArray = []
    var soundURL: [URL]?
    var finished: Bool = false
    
    // MARK: countsURL
    // This swift will play the audio file associated with the URL address and initiate array
    var countsURL = 0
    var audioFileArray: [Int] = []
    
    // Record Screen
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordStatus: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Record screen preparation
        stopButton.isEnabled = false
        recordButton.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This action will be performed on recordButton press
    @IBAction func recordButton(_ sender: UIButton){
    
            // Function that passes true that the app is recording and to follow the appropiate actions
            configUI(recording: true, recordingTitle: recordingTitle)
        
            // After recording title labelStatus will be changed to "Story Page" instead of "Title"
            recordingTitle = false
        
        // MARK: Created URL for recording audio file
        recordingURL()
    }
    
    // This action will be performed on stopButton press
    @IBAction func stopButton(_ sender: UIButton){
        
        // Function that passes false that the app is recording and to follow the appropiate actions
        configUI(recording: false)
        
        // Stops the audio recording and sets the setActive to inactive
        audioRecorder.stop()
        
        // Counts how many times the audioRecorder.stop() was performed to later assign that specific number to array element contains the URL address for that specific audio file
        countsURL += 1
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        // Prompt user if they want to create another story page
        createAlert(title: "Do you need to record another page? ", message: " ")
        
    }
    
    // ________________ List of Functions __________________
    
    // Conducts condition statement to test whether the app is recording or stopped and performs the appriopiate action
    func configUI(recording: Bool, recordingTitle: Bool){
        
        // Conditional statement that tests whether the recording is for book title or for the story page and changes recordStatus
        if recordingTitle{
            let labelStatus: String = "Title"
            
            if recording{
                stopButton.isEnabled = true
                recordButton.isEnabled = false
                recordStatus.text = "Recording......"
            } else {
                stopButton.isEnabled = false
                recordButton.isEnabled = true
                recordStatus.text = "Tap to Record " + labelStatus
            }
            
        }
        
    }
        
    // MARK: Create an alert to determine if the user is done record their voice for the book or to continue to record
    func createAlert( title: String, message: String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // Creates Buttons for alert
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in self.performSegue(withIdentifier: "addingAnotherPage", sender: self)
            
            // "Yes" button was pressed and will have the user record another Story Page
            print(" PRINT URL:   ")
            print("Yes")
            print(self.recordingURL())
            
        }))
//    
//        // Allows the user to move from the MiddleMan view to Read2MeScene view
//        performSegue(withIdentifier: "reroutedToReadStory", sender: self)
//        
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: "reroutedToReadStory", sender: self)
            
            // "No" button was pressed and sent to play Story
            print(" PRINT URL:   ")
            print("No")
            print(self.recordingURL())
            
            /*
             *  ENTER CODE TO GO TO  STORY BELOW
             */
            
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    // Method that assigns final variable pathways and URL name to recorded audio so it can be called and manipulated at a later time
    func recordingURL(){
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,  true)[0] as String
        
        // Creates URL pathway
        let recordingName = "recordVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        print(filePath)
        
        // Adds URL file path to soundURL to reference later during playback
        soundURL?.append(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // Declaring function for config
    func configUI(recording: Bool){
        
        if recording{
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            recordStatus.text = "Recording.........."
        } else {
            recordButton.isEnabled = true
            recordStatus.isEnabled = false
            recordStatus.text = "Tap to Record"
        }
    }
    
    // Function that verifies if the recording was successful and perform the performSegue() else alert user "Recording was not successfull" 
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            performSegue(withIdentifier: "recordStoryScreen", sender: audioRecorder.url)
        } else {
            
            /* 
             *  CREATE AN ALERT THAT WILL NOTIFY USER RECORDING WAS NOT SUCCESSFUL
             */
            print("Recording was not successfull")
        }
    }
    
    // Prepares the Controller for PlaySoundViewController segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordStoryScreen" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            
            // Set the recorded audio URL to be the URL comoing in from the sender which is the performSegue function's parameter "audioRecorder.url"
            let recordedAudioURL = sender as! URL
                
                // Set the recordedStoryURL property in the PlaySoundsViewController. This is how the recording is being sent to the PlaySoundsVC.
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
        }
    
}





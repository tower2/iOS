//
//  ViewController.swift
//  tapper-extreme
//
//  Created by Jermaine Lorenzo Goins on 10/18/15.
//  Copyright © 2015 Jermaine Lorenzo Goins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Properties
    var maxTaps = 0
    var currentTaps = 0
    
    
    // Outlets
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var tapsBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    
    @IBAction func onCoinTapped(_ sender: UIButton) {
        currentTaps += 1;
        updateTapsLbl();
        
        if isGameOver() {
            restartGame()
        }
        
    }
    
    // Happens after button press
    @IBAction func onPlayBtnPressed(_ sender: UIButton!) {

        
        if howManyTapsTxt.text != nil && howManyTapsTxt.text != "" {
            
            //hidden buttons and text 
            logoImg.isHidden = true
            tapsBtn.isHidden = true
            howManyTapsTxt.isHidden = true
            
            playBtn.isHidden = false
            tapsLbl.isHidden = false
            
            //Max taps and current taps
            maxTaps = Int (howManyTapsTxt.text!)!
            currentTaps = 0
            
            // Updating number of taps
            updateTapsLbl();
            
        }
    }
    
    // Restart game
    func restartGame() {
        
        // Hidden buttons and text fields
        
        maxTaps = 0;
        howManyTapsTxt.text = "";
        
        logoImg.isHidden = false;
        tapsBtn.isHidden = false;
        howManyTapsTxt.isHidden = false;
        
        playBtn.isHidden = true;
        tapsLbl.isHidden = true;
        
    }
    
    // Ends game
    func isGameOver () -> Bool{
        if currentTaps >= maxTaps{
            return true;
        } else {
            return false ;
        }
        
    }
    
    // Updating number of taps
    func updateTapsLbl() {
        tapsLbl.text = "\(currentTaps) Taps ";
    }

}

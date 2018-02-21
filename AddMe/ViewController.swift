//
//  ViewController.swift
//  AddMe
//
//  Created by Jermaine Lorenzo Goins on 12/6/15.
//  Copyright © 2015 Jermaine Lorenzo Goins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Calculating variables
    var insertedNumber: Int = 0;
    var numberCount: Int = 0;
    var sum: Int = 0;
    var convertedNumberAdded = 0;
    
    // Outlets
    @IBOutlet weak var numberAdd: UITextField!
    @IBOutlet weak var addMeTitle: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addToBeginLabel: UILabel!
    @IBOutlet weak var balledPaperButton: UIButton!
    @IBOutlet weak var clickLabel: UITextField!
    
    // Button press action
    @IBAction func balledPaperButtonPress (_ sender : UIButton) {

        
        // Checking textField for input & calculating numbers
        if numberAdd.text != nil || numberAdd.text != " " {
            
            addMeTitle.isHidden = false;
            balledPaperButton.isHidden = false;
            clickLabel.isHidden = false;
            numberAdd.isHidden = false;
            
            addButton.isHidden = true;
            addToBeginLabel.isHidden = true;
            
            convertedNumberAdded = Int(numberAdd.text!)!
            
        
        }
    }
    
    @IBAction func pressedAddButton (_ sender: UIButton) {
        if numberCount <= 5 {
            
            displayClickLabel();
            sum = convertedNumberAdded + numberCount;
            numberCount += 1;
            
            
            
        }
        
    }

    func displayClickLabel () {
        clickLabel.text = " \(sum) = \(convertedNumberAdded) + \(numberCount) ";
    }
}


//
//  Read2MeScene.swift
//  Read2Me
//
//  Created by Jermaine Lorenzo Goins on 2/2/18.
//  Copyright © 2018 Jermaine Lorenzo Goins. All rights reserved.
//

import Foundation
import UIKit


//MARK: Properties
class Read2MeScene: UIViewController{
    
    // Variable preparing app for recording story title and story content
    
    // Connect objects to pages
    // Main Page
    @IBOutlet weak var newStory: UIButton!
    
    // Will hide newStory button when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide newStory until next version app
        newStory.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

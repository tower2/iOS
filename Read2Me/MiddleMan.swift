//
//  MiddleMan.swift
//  Read2Me
//
//  Created by Jermaine Lorenzo Goins on 2/15/18.
//  Copyright © 2018 Jermaine Lorenzo Goins. All rights reserved.
//


import Foundation
import UIKit

class MiddleMan: UIViewController {
    
    // Perform commands below before anything else
    override func viewDidLoad() {
        super.viewDidLoad()
       
        performSegue(withIdentifier: "recordAnotherPage", sender:self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}






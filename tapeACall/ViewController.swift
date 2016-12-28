//
//  ViewController.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/22/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
 
    //view full screen
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // change title and background color of navigation color
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

}

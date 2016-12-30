//
//  ViewController.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/20/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBAction func recordBtnPressed(_ sender: UIButton)
    {

        callNumber(phoneNumber: "+17652312345")
        
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:URL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}


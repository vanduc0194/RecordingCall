//
//  SettingVC.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/20/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit
import MessageUI


class SettingVC: ViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var indentifier:String!
        
        switch indexPath.row  {
        case 0:
            indentifier = "BeepCell"
            break
        case 1:
            indentifier = "Account"
            break
        case 2:
            indentifier = "AccessNumber"
            break
        case 3:
            indentifier = "Law"
            break
        case 4:
            indentifier = "TellFriend"
            break
        case 5:
            indentifier = "Upgrade"
            break
        case 6:
            indentifier = "Support"
            break
        default:
            indentifier = "Unknow"
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: indentifier, for: indexPath) as! ItemSettingCell
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row  {
        case 1:
            
            break
        case 2:
          
            break
        case 3:
            displayRecordingLaw()
            break
        case 4:
            tellFriend()
            break
        case 5:
            
            break
        case 6:
            support()
            break
        default:
            
            break
        }
    }
    
    //func show menu on tellFriend setting pressed
    func tellFriend() {
        // optionMenu
        let optionMenu = UIAlertController(title: nil, message: "Thanks for sharing this app", preferredStyle: .actionSheet)
        
        // declare some action
        
        // copy URL
        let urlAction = UIAlertAction(title: "Copy URL", style: .default){ (action:UIAlertAction!) in
            UIPasteboard.general.string = "http://..."
        }
        
        // email
        let emailAction = UIAlertAction(title: "Email", style: .default){ (action:UIAlertAction!) in
            
        }

        //message
        let messageAction = UIAlertAction(title: "Message", style: .default){ (action:UIAlertAction!) in
            let url:URL = URL(string: "sms://")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        // facebook
        let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        
        })
        
        // twitter
        let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // add to option menu
        optionMenu.addAction(urlAction)
        optionMenu.addAction(emailAction)
        optionMenu.addAction(messageAction)
        optionMenu.addAction(facebookAction)
        optionMenu.addAction(twitterAction)
        optionMenu.addAction(cancelAction)
        
        // set
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    // func show menu when suport pressed
    func support() {
        // optionMenu
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // declare some action
        
        // copy privacy
        let privacyAction = UIAlertAction(title: "Privacy Policy", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // asked
        let askAction = UIAlertAction(title: "Frequently Asked Questions", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        //contact
        let contactAction = UIAlertAction(title: "Contact Us", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // add to option menu
        optionMenu.addAction(privacyAction)
        optionMenu.addAction(askAction)
        optionMenu.addAction(contactAction)
        optionMenu.addAction(cancelAction)
        
        // set
        self.present(optionMenu, animated: true, completion: nil)
    }
    

    
    
    
    //recording to launch recording law
    func displayRecordingLaw(){
        let msg="The material we make available in respect to telephone recording laws..."
        
        let alertController = UIAlertController(title: "Disclaimer", message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        
        let agreeAction = UIAlertAction(title: "I Agree", style: .default) { action in
           UIApplication.shared.open(URL(string: "https://en.wikipedia.org/wiki/Telephone_recording_laws")!, options: [:], completionHandler: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(agreeAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //
    
    @IBAction func closeBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func rateBtnPressed(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "http://google.com")!, options: [:], completionHandler: nil)
    }
    @IBAction func followBtnPressed(_ sender: UIButton) {
         UIApplication.shared.open(URL(string: "http://google.com")!, options: [:], completionHandler: nil)
    }
    @IBAction func likeBtnPressed(_ sender: UIButton) {
         UIApplication.shared.open(URL(string: "http://google.com")!, options: [:], completionHandler: nil)
    }
    

}

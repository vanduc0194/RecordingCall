//
//  RecordingsVC.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/20/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit

class RecordingsVC: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var playSongView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 //   var recording = Recording!
    var recordings = [Recording]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dowloadRecordingData {   }

    }
    
    func dowloadRecordingData (completed: @escaping DownloadComplete) {
        
        Alamofire.request(URL_RECORDING).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary <String, String> {
                for obj in dict {
                    let recording = Recording(dict: obj)
                    self.recordings.append(recording)
                }
                self.tableView.reloadData()
                
            }
            completed()
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemRecordCell", for: indexPath) as! ItemRecordCell {
            
            let recording = recordings[indexPath.row]
            cell.configureCell(recording: recording)
            return cell
        } else {
            return ItemRecordCell()
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // tableView.layoutMargins.bottom = 50
        //var record: Recording!
      
        var linkRecord = recordings[indexPath.row].link
        let url = NSURL(string: "http://radio.spainmedia.es/wp-content/uploads/2015/12/tailtoddle_lo4.mp3")
        print("the url = \(url!)")
        self.downloadFileFromURL(url!)

        playSongView.isHidden = false
    }
    
    
    func downloadFileFromURL(url: URL){
        var downloadTask:NSURLSessionDownloadTask
        downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(url, completionHandler: { (URL, response, error) -> Void in
            
            self.play(URL!)
            
        })
        
        downloadTask.resume()
        
    }
    
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOfURL: url)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
  
}

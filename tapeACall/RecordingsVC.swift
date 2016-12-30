//
//  RecordingsVC.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/20/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class RecordingsVC: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recordPlayer: AVAudioPlayer!
    
    @IBOutlet weak var playSongView: UIView!

    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var pauseBtn: UIButton!

    @IBOutlet weak var sliderTime: UISlider!

    @IBOutlet weak var tableView: UITableView!

    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playBtn(_ sender: UIButton) {
            playBtn.isHidden = true
            pauseBtn.isHidden = false
            recordPlayer.play()
    }
    
    @IBAction func pauseBtn(_ sender: UIButton) {
            playBtn.isHidden = false
            pauseBtn.isHidden = true
            recordPlayer.stop()
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func sliderTime(_ sender: UISlider) {
        recordPlayer.currentTime = TimeInterval(sliderTime.value)

    }
    
 
    //   var recording = Recording!
    var recordings = [Recording]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.dowloadRecordingData {   }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    func dowloadRecordingData (completed: @escaping DownloadComplete) {
        let url = URL(string: "http://tape-a-call.herokuapp.com/getfile/")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let parameters = ["phoneNumber" : "+841678355212"]
        do {
         urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error errrroooor!!!")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(urlRequest).responseJSON { response in
            print(urlRequest)
            print("Start load data!!!")
            print(response)
           // if let dict = response.result.value as? Dictionary<String, AnyObject>{
            if let array = response.result.value as? Array<Any> {
                for obj in array  {
                    let recording = Recording(dict: obj as! Dictionary<String, AnyObject>)
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemRecordCell", for: indexPath) as? ItemRecordCell {
            let recording = recordings[indexPath.row]
            cell.configureCell(recording: recording)
            return cell
        } else {
            return ItemRecordCell()
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //playSongView.isHidden = false
        
        //download recording from Internet
        let url = recordings[indexPath.row].link
        let path = downloadRecording(url: "http://radio.spainmedia.es/wp-content/uploads/2015/12/ogilvy.mp3")
        
        //play recording 
        playRecording(path: path)
        
    }
    
    
    func downloadRecording(url: String) -> String {
        if let audioUrl = URL(string: url) {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                playSongView.isHidden = false

                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                        self.playSongView.isHidden = false

                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
            
            print(destinationUrl.path)
            return destinationUrl.path
    
        } else {
            return ""
        }
    }
    
    func playRecording(path: String) {
        
        //play audio with path
        playBtn.isHidden = true

        do {
            
            recordPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            recordPlayer.prepareToPlay()
//            recordPlayer.numberOfLoops = -1
            recordPlayer.play()

            sliderTime.maximumValue = Float(recordPlayer.duration)
            sliderTime.value = 0.0
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            
        } catch let err as NSError{
            
            print(err.debugDescription)
            
        }
    }
    
    func updateTime(_ timer: Timer) {
        sliderTime.value = Float(recordPlayer.currentTime)
        if recordPlayer.currentTime == 0.0 {
            playBtn.isHidden = false
            pauseBtn.isHidden = true
        }
    }
    
}

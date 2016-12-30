//
//  Recording.swift
//  tapeACall
//
//  Created by NguyenVanDuc on 12/27/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import Foundation
import Alamofire

class Recording {
    
    private var _name: String!
    private var _date: String!
    private var _duration: String!
    private var _link: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var duration: String {
        if _duration == nil {
            _duration = ""
        }
        return _duration
    }
    
    var link: String {
        if _link == nil {
            _link = ""
        }
        return _link
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let name = dict["idRec"] as? String {
            self._name = name
        }
        
        if let timeStart = dict["timeStart"] as? String {
            self._date = convertDateFormatter(date: timeStart)
        
            if let timeEnd = dict["timeEnd"] as? String {
                let dateStart = convertStringDateToDate(stringDate: timeStart)
                let dateEnd = convertStringDateToDate(stringDate: timeEnd)
                let time: TimeInterval = (dateEnd.timeIntervalSince(dateStart))
                self._duration = stringFromTimeInterval(interval: time) as String!
            }
        }
        if let link = dict["urlRec"] as? String {
            self._link = link
        }
        
    }
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "EEEE MMM yyyy HH:mm"///this is you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    func convertStringDateToDate(stringDate: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: stringDate)
        return date!
        
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
}

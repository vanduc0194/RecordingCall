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
    private var _time: String!
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
    
    var time: String {
        if _time == nil {
            _time = ""
        }
        return _time
    }
    
    var link: String {
        if _link == nil {
            _link = ""
        }
        return _link
    }
    
    init(dict: Dictionary<String, String>) {
        
        if let name = dict["idRec"] as? String {
            self._name = name
        }
        
        if let date = dict["timeStart"] as? String {
            self._date = date
        }
        
        if let timeEnd = dict["timeEnd"] as? String {
            self._time = timeEnd - self._date
        }
        
        if let link = dict["urlRec"] as? String {
            self._link = link
        }
        
    }
    
}

//
//  ItemRecordCellTableViewCell.swift
//  tapeACall
//
//  Created by Pham Huu Dai on 12/20/16.
//  Copyright © 2016 Pham Huu Dai. All rights reserved.
//

import UIKit

class ItemRecordCell: UITableViewCell {

    @IBOutlet weak var nameRecordLbl: UILabel!
    
    @IBOutlet weak var dateRecordingLbl: UILabel!
    
    @IBOutlet weak var timeRecordLbl: UILabel!
    
    private var link: String!

    func configureCell(recording: Recording) {
        nameRecordLbl.text = recording.name
        dateRecordingLbl.text = recording.date
        timeRecordLbl.text = recording.time
        link = recording.link
    }

}

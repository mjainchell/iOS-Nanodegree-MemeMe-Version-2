//
//  MemeTableViewCell.swift
//  MemeMeVersion2
//
//  Created by Mark Jainchell on 6/4/17.
//  Copyright © 2017 Mark Jainchell. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var tableCellMemeImage: UIImageView!
    @IBOutlet weak var tableCellTopText: UILabel!
    @IBOutlet weak var tableCellBottomText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Content mode changed to .scaleAspectFill for demonstration purposes
        tableCellMemeImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

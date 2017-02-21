//
//  MessageItemCell.swift
//  PNDemo
//
//  Created by Shivi on 2/19/17.
//  Copyright © 2017 NaviSpin. All rights reserved.
//

import UIKit

class MessageItemCell: UITableViewCell {
    
    func updateWithMessageItem(item:NewsItem) {
        self.textLabel?.text = item.title
        // self.detailTextLabel?.text = item.date
        print("DATE FORMAT000: \(item.date)")
        self.detailTextLabel?.text = DateParser.displayString(fordate:item.date)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

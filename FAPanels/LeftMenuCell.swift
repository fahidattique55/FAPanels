//
//  LeftMenuCell.swift
//  FAPanels
//
//  Created by Fahid Attique on 10/07/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {


    @IBOutlet var menuOption: UILabel!
    @IBOutlet var menuImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

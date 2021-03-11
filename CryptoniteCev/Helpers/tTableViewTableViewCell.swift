//
//  tTableViewTableViewCell.swift
//  CryptoniteCev
//
//  Created by user177257 on 3/11/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

class tTableViewTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel : UILabel!
    
    static let identifier = "id"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

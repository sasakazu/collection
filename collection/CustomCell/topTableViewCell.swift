//
//  topTableViewCell.swift
//  collection
//
//  Created by 笹倉一也 on 2021/11/30.
//

import UIKit

class topTableViewCell: UITableViewCell {

    
    @IBOutlet weak var topImageCell: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.topImageCell.layer.cornerRadius = self.topImageCell.frame.size.width * 0.5
        self.topImageCell.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

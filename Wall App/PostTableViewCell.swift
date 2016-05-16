//
//  PostTableViewCell.swift
//  Wall App
//
//  Created by sphota on 5/16/16.
//  Copyright © 2016 Lex Levi. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
	
	@IBOutlet weak var posterLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var postLabel: UITextView!
	

    override func awakeFromNib() {
        super.awakeFromNib()
		
		postLabel.layer.borderWidth = 1.0
		postLabel.layer.borderColor = UIColor.blackColor().CGColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PostTableViewCell.swift
//  Pods
//
//  Created by Pavan Powani on 16/12/16.
//
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var contentTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

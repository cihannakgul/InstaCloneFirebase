//
//  FeedCell.swift
//  instaCloneFirebase
//
//  Created by cihan on 11.11.22.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblLikes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

    @IBAction func likeClicked(_ sender: Any) {
    }
}

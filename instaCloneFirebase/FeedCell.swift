//
//  FeedCell.swift
//  instaCloneFirebase
//
//  Created by cihan on 11.11.22.
//

import UIKit
import Firebase
import FirebaseFirestore
class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblLikes: UILabel!
    
    @IBOutlet weak var lblDocumentId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

    @IBAction func likeClicked(_ sender: Any) {
       
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(lblLikes.text!){
            let likeStore = ["likes" : likeCount+1] as [String : Any]
            
            firestoreDatabase.collection("Posts").document(lblDocumentId.text!).setData(likeStore, merge: true)
        }
    }
}

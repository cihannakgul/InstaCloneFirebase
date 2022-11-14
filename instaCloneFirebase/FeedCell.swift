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
    
    var PostAuthor :String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    func CreateMessage(Message:String){
        let alert = UIAlertController(title: "Hey!!", message: Message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.window?.rootViewController?.present(alert, animated: true)
    }

    
   func isItMeToLiked(author : String){
       if let likeCount = Int(lblLikes.text!){
           let firestoreDatabase = Firestore.firestore()
            
           
           if author == Auth.auth().currentUser?.email as? String{
               self.CreateMessage(Message:  "You cannot like your own post!")
           }else{
               
               let likeStore = ["likes" : likeCount+1] as [String : Any]
               
               firestoreDatabase.collection("Posts").document(lblDocumentId.text!).setData(likeStore, merge: true)
               
               self.CreateMessage(Message: "You liked \(author)'s post")
           }
           
            
           
       }
        
    }
    @IBAction func likeClicked(_ sender: Any) {
       
        let firestoreDatabase = Firestore.firestore()
        let username = firestoreDatabase.collection("Posts").document(lblDocumentId.text!).getDocument { document, error in
            
            guard let document = document, document.exists else {
                            print("Document does not exist")
                            return
                        }
                        let dataDescription = document.data()
            if let postby = dataDescription?["postedBy"] as? String{
                self.PostAuthor = postby
                
                self.isItMeToLiked(author: self.PostAuthor)
                
            }
                        
        }
     
    }
}

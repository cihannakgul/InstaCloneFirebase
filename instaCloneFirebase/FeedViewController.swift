//
//  FeedViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allPosts.count
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    var allPosts = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.lblUsername.text = allPosts[indexPath.row].userEmail
        cell.lblLikes.text = String(allPosts[indexPath.row].like)
        cell.lblComment.text = allPosts[indexPath.row].userComment
        cell.lblDocumentId.text = allPosts[indexPath.row].documentID
        
        cell.userImage.sd_setImage(with: URL(string: allPosts[indexPath.row].userImage))
        cell.userImage.sd_setImage(with: URL(string: allPosts[indexPath.row].userImage), placeholderImage: nil, options: .highPriority) { image, error, type, url in
            if error != nil{
                cell.userImage.image = image
            }
        }
    
        
        return cell
        
        
    }
    
    func getData(){
        let fireStoreDatabase = Firestore.firestore()
     //   let settings = fireStoreDatabase.settings
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
                
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.allPosts.removeAll()
                    for document in snapshot!.documents{
                        let documentID = document.documentID

                       
                        if let username = document.get("postedBy") as? String{
                            if let userComment = document.get("postComment") as? String {
                                if let imageUrl = document.get("imageUrl") as? String {
                                    if let likes = document.get("likes") as? Int {
                                        let personWho = User(userEmail: username, userComment: userComment, userImage: imageUrl, like: likes, documentID: documentID)
                                        
                                        self.allPosts.append(personWho)
                                    }
                                }
                                
                                
                                
                            }
                           
                            
                            
                          
                            
                            
                        }
                        print(documentID)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }


}

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
        cell.userImage.image = UIImage(systemName: "pencil")
        
        return cell
        
        
    }
    
    func getData(){
        let fireStoreDatabase = Firestore.firestore()
     //   let settings = fireStoreDatabase.settings
        fireStoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
                
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    for document in snapshot!.documents{
                        
                       
                        if let username = document.get("postedBy") as? String{
                            if let userComment = document.get("postComment") as? String {
                                if let imageUrl = document.get("imageUrl") as? String {
                                    if let likes = document.get("likes") as? Int {
                                        let personWho = User(userEmail: username, userComment: userComment, userImage: imageUrl, like: likes)
                                        
                                        self.allPosts.append(personWho)
                                    }
                                }
                                
                                
                                
                            }
                           
                            
                            
                          
                            
                            
                        }
                        let documentID = document.documentID
                        print(documentID)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }


}

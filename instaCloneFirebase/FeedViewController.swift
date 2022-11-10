//
//  FeedViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit
import Firebase
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return 10
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.lblUsername.text = "Heyy"
        cell.lblLikes.text = "5"
        cell.lblComment.text = "First cell!"
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
                
            }
        }
        
    }


}

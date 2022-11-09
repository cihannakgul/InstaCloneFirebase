//
//  SettingsViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func LogoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logout", sender: nil)
        }
        catch{
            print("error")
        }
        
        
        
    }
    

}

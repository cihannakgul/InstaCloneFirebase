//
//  SettingsViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func LogoutClicked(_ sender: Any) {
        performSegue(withIdentifier: "logout", sender: nil)
        
    }
    

}

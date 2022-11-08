//
//  ViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("first git test")
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
    }
    
    
    
    
    @IBAction func SignInClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    

}


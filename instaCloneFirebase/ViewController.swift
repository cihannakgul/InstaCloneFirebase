//
//  ViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        if txtEmail.text != "" && txtPassword.text != ""{
            
       
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authdata, error in
                
                if error != nil{
                    let errorNew = error?.localizedDescription as! String
                    self.CreateMessage(Message: errorNew)
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            CreateMessage(Message: "Username or password??")
        }
        
    }
    
    
    
    
    @IBAction func SignInClicked(_ sender: Any) {
        
       
       
    }
    
    func CreateMessage(Message:String){
        let alert = UIAlertController(title: Message, message: "Hey!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    

}


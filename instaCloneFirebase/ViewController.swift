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
       
        SessionControl()
    }
    
    func SessionControl(){
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil{
            performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) { // Kaydol
        if txtEmail.text != "" && txtPassword.text != ""{
            
       
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authdata, error in
                
                if error != nil{
                   
                    self.CreateMessage(Message: error?.localizedDescription ?? "Error")
                }else{
                    
                 
                   // self.CreateMessage(Message: "You have successfully registered \(authdata?.user)")
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            CreateMessage(Message: "Username or password??")
        }
        
    }
    
    
    
    
    @IBAction func SignInClicked(_ sender: Any) { // Giriş yap
        
        if txtEmail.text != "" && txtPassword.text != ""{
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { authdata, error in
                if error != nil{
                     
                    self.CreateMessage(Message: error?.localizedDescription ?? "Error")
                }else{
                   // self.CreateMessage(Message: "Welcome \(authdata?.user) have a nice day!" )
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
        }
        else{
            
            CreateMessage(Message: "Please fill the textfields...")
        }
       
    }
    
    func CreateMessage(Message:String){
        let alert = UIAlertController(title: "Hey!!", message: Message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    

}


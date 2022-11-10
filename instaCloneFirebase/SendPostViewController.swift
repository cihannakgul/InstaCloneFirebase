//
//  SendPostViewController.swift
//  instaCloneFirebase
//
//  Created by cihan on 08.11.22.
//

import UIKit
import Firebase

class SendPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var SendButton: UIButton!
    
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var didImageSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(CloseKeyboard))
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImagePicker))
        imageView.addGestureRecognizer(gestureRecognizer)
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func ImagePicker(){
        
        
            let picker = UIImagePickerController()
                        picker.delegate = self
                        picker.sourceType = .photoLibrary
                        picker.allowsEditing = true
                        present(picker, animated:true, completion: nil)
                        SendButton.isEnabled = true
                        didImageSelected = true
        
        
        
                    
        
    }
    
    func CreateMessage(Message:String){
        let alert = UIAlertController(title: "Hey!!", message: Message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let oldImage = info[.originalImage] as? UIImage
        
        imageView.image = resizeImageWithAspect(image: oldImage!, scaledToMaxWidth: 200, maxHeight: 200)
        self.dismiss(animated: true)
    }
    
    @objc func CloseKeyboard(){
        
        view.endEditing(true)
        
    }
    

    @IBAction func SendPostClicker(_ sender: Any) {
        
        
        let uuid = UUID().uuidString
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    
                    self.CreateMessage(Message: error?.localizedDescription ?? "Error")
                    
                }
                else if self.didImageSelected == true{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageURL = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl": imageURL!, "postedBy" : Auth.auth().currentUser!.email ?? "Who", "postComment": self.txtComment.text!, "date":FieldValue.serverTimestamp(), "likes" : 0 ] as [String:Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    self.CreateMessage(Message: error?.localizedDescription ?? "Error")
                                }else{
                                    self.didImageSelected = false
                                    self.txtComment.text=""
                                    self.imageView.image = UIImage(systemName: "square.and.arrow.up.circle")
                                    self.CreateMessage(Message: "Your post sended to feed!")
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            })
                            
                            
                        }
                        
                    }
                }
                else{
                    self.CreateMessage(Message: "Please select a image")
                }
                
            }
        }
    }
    
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage? {
           let oldWidth = image.size.width;
           let oldHeight = image.size.height;

           let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;

           let newHeight = oldHeight * scaleFactor;
           let newWidth = oldWidth * scaleFactor;
           let newSize = CGSize(width: newWidth, height: newHeight)

           UIGraphicsBeginImageContextWithOptions(newSize,false,UIScreen.main.scale);

           image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
           let newImage = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           return newImage
       }
    
}

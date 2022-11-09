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
        
        if !didImageSelected{
            let picker = UIImagePickerController()
                        picker.delegate = self
                        picker.sourceType = .photoLibrary
                        picker.allowsEditing = true
                        present(picker, animated:true, completion: nil)
                        SendButton.isEnabled = true
                        didImageSelected = true
        }
        
                    
        
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
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let imageReference = mediaFolder.child("image.jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    print(error?.localizedDescription)
                    
                }
                else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageURL = url?.absoluteString
                            print(imageURL)
                        }
                    }
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

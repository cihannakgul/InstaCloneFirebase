//
//  User.swift
//  instaCloneFirebase
//
//  Created by cihan on 11.11.22.
//

import Foundation


class User{
    var userEmail : String!
    var userComment : String!
    var userImage : String!
    var like : Int!
    var documentID : String!

    init( userEmail:String,  userComment:String, userImage : String, like: Int, documentID: String){
        self.userEmail = userEmail
        self.userComment = userComment
        self.userImage = userImage
        self.like = like
        self.documentID = documentID
        
    }

    
}

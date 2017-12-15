//
//  User.swift
//  myApplication
//
//  Created by Rob Dekker on 06-12-17.
//  Copyright © 2017 Rob Dekker. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}

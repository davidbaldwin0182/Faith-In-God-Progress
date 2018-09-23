//
//  User.swift
//  Faith In God Progress
//
//  Created by David Baldwin on 8/25/18.
//  Copyright © 2018 David Baldwin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

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

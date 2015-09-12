//
//  File.swift
//  Autolayout
//
//  Created by Andriy Bas on 8/21/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let email: String
    let password: String
    
    init(name: String, email : String, password : String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    static func login(email : String, password : String) -> User? {
        if let user = database[email] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database : [String:User] = {
        var db = [String:User]()
        for user in [
                User(name: "img1", email: "aa", password: "aa"),
                User(name: "img2", email: "bb", password: "bb"),
                User(name: "img1", email: "cc", password: "cc")
            ] {
                db[user.email] = user
        }
        return db
    }()
    
    
}

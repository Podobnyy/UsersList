//
//  User.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import Foundation
import CoreData

struct User: Codable {
    var firstName: String
    var lastName: String
    var ava: String
    var avaData: Data?
    var email: String
    var phoneNumber: String
    var userID: String
    
    init(firstName: String, lastName: String, ava: String, email: String, phoneNumber: String, userID: String ) {
        self.firstName = firstName
        self.lastName = lastName
        self.ava = ava
        
        let url = URL(string: ava)
        avaData = try? Data(contentsOf: url!)

        self.email = email
        self.phoneNumber = phoneNumber
        self.userID = userID
    }
    
    init(firstName: String, lastName: String, ava: String, avaData: Data, email: String, phoneNumber: String,  userID: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.ava = ava
        self.avaData = avaData
        self.email = email
        self.phoneNumber = phoneNumber
        self.userID = userID
    }
}

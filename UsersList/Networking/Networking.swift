//
//  Networking.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import Foundation
import Alamofire

typealias usersLoadComplitionalBlock = (_ result: [User]?) -> ()

class Networking {
    
    static let shared = Networking()
    var userCompBlock: usersLoadComplitionalBlock?

    func getUsers(list: Int, usersCount: Int, complitional: @escaping usersLoadComplitionalBlock){
 
        let urlString: String = "https://randomuser.me/api/?page=\(list)&results=\(usersCount)&seed=abc&inc=name,picture,email,phone"
        
        AF.request(urlString).responseJSON{ [weak self] response in
            var users = [User] ()
            if let JSON = (response.value as? NSDictionary){
                let usersRaw: Array = JSON["results"] as! Array<Any>
                for userRaw in usersRaw{
                    users.append((self?.getUserFromDictionary(dictionary: userRaw as! NSDictionary))!)
                }
            }
            complitional(users)
        }
    }
    
    // create user from dictionary
    func getUserFromDictionary(dictionary: NSDictionary) -> User{
        let name = dictionary["name"] as! NSDictionary
        let firstName = name["first"] as! String
        let lastName = name["last"] as! String
        
        let picture = dictionary["picture"] as! NSDictionary
        let ava = picture["large"] as! String
        
        let email = dictionary["email"] as! String
        let phoneNumber = dictionary["phone"] as! String
        
        return User.init(firstName: firstName, lastName: lastName, ava: ava, email: email, phoneNumber: phoneNumber, userID: "")
    }
}

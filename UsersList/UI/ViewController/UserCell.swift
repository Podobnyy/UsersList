//
//  UserCell.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet  weak var name: UILabel!
    @IBOutlet  weak var phoneNumber: UILabel!
    @IBOutlet  weak var ava: UIImageView!
    
    func setup(user: User){
        self.name.text = user.firstName + " " + user.lastName
        self.phoneNumber.text = user.phoneNumber
        
        if (user.avaData != nil) {
            self.ava.image = UIImage(data: user.avaData!)
        } else{
            self.ava.image = UIImage()
        }
        self.ava.layer.cornerRadius = ava.frame.height / 2
    }
}


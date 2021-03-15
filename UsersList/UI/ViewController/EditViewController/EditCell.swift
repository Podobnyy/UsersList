//
//  EditCell.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit

class EditCell: UITableViewCell {
    @IBOutlet  weak var label: UILabel!
    @IBOutlet  weak var textField: UITextField!
    
    func setup(field: Field){
        self.label.text = field.label
        self.textField.text = field.textField
    }
}

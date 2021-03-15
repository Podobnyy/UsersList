//
//  Field.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import Foundation

struct Field: Codable {
    var label: String
    var textField: String
    
    init(label: String, textField: String) {
        self.label = label
        self.textField = textField
    }
}

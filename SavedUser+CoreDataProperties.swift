//
//  SavedUser+CoreDataProperties.swift
//  
//
//  Created by Сергей Александрович on 14.03.2021.
//
//

import Foundation
import CoreData


extension SavedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUser> {
        return NSFetchRequest<SavedUser>(entityName: "SavedUser")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var ava: String?
    @NSManaged public var avaData: Data?
    @NSManaged public var email: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var id: String?

}

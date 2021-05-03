//
//  Character+CoreDataProperties.swift
//  
//
//  Created by Lech Lipnicki on 2021-05-03.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var characterId: Int16
    @NSManaged public var name: String?
    @NSManaged public var birthday: String?
    @NSManaged public var status: String?
    @NSManaged public var nickname: String?

}

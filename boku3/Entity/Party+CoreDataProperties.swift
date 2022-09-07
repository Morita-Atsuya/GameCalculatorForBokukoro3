//
//  Party+CoreDataProperties.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData


extension Party {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Party> {
        return NSFetchRequest<Party>(entityName: "Party")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var dougutati: DouguTati?
    @NSManaged public var character: NSSet?
    
    public var characterArray: [Character] {
        let set = character as? Set<Character> ?? []
        return set.sorted{
            $0.id < $1.id
        }
    }

}

// MARK: Generated accessors for character
extension Party {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: Character)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: Character)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}

extension Party : Identifiable {
    
}

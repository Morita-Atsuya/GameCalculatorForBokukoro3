//
//  DouguTati+CoreDataProperties.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData


extension DouguTati {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DouguTati> {
        return NSFetchRequest<DouguTati>(entityName: "DouguTati")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var dougu: NSSet?
    @NSManaged public var party: NSSet?
    
    public var douguArray: [Dougu] {
        let set = dougu as? Set<Dougu> ?? []
        return set.sorted{
            $0.id < $1.id
        }
    }


}

// MARK: Generated accessors for dougu
extension DouguTati {

    @objc(addDouguObject:)
    @NSManaged public func addToDougu(_ value: Dougu)

    @objc(removeDouguObject:)
    @NSManaged public func removeFromDougu(_ value: Dougu)

    @objc(addDougu:)
    @NSManaged public func addToDougu(_ values: NSSet)

    @objc(removeDougu:)
    @NSManaged public func removeFromDougu(_ values: NSSet)

}

// MARK: Generated accessors for oarty
extension DouguTati {

    @objc(addOartyPbject:)
    @NSManaged public func addToParty(_ value: Party)

    @objc(removePartyObject:)
    @NSManaged public func removeFromParty(_ value: Party)

    @objc(addParty:)
    @NSManaged public func addToParty(_ values: NSSet)

    @objc(removeParty:)
    @NSManaged public func removeFromParty(_ values: NSSet)

}

extension DouguTati : Identifiable {

}

//
//  Dougu+CoreDataProperties.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData


extension Dougu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dougu> {
        return NSFetchRequest<Dougu>(entityName: "Dougu")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var powerUpForAll: String?
    @NSManaged public var powerUpForAllAmount: Int16
    @NSManaged public var specialE: String?
    @NSManaged public var specialE_amount: Int16
    @NSManaged public var uuid: UUID?
    @NSManaged public var dougutati: NSSet?

}

// MARK: Generated accessors for dougutati
extension Dougu {

    @objc(addDougutatiObject:)
    @NSManaged public func addToDougutati(_ value: DouguTati)

    @objc(removeDougutatiObject:)
    @NSManaged public func removeFromDougutati(_ value: DouguTati)

    @objc(addDougutati:)
    @NSManaged public func addToDougutati(_ values: NSSet)

    @objc(removeDougutati:)
    @NSManaged public func removeFromDougutati(_ values: NSSet)

}

extension Dougu : Identifiable {
    func specialEffectReplace (keyPath: ReferenceWritableKeyPath<Dougu,Optional<String>>, newEffect: String){
        self[keyPath: keyPath] = newEffect
    }
    func specialEffectAmountReplace (keyPath: ReferenceWritableKeyPath<Dougu,Int16>, newAmount: Int16){
        self[keyPath: keyPath] = newAmount
    }
}

extension Dougu {
   
}

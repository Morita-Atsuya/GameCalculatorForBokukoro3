//
//  Character+CoreDataProperties.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var attackTipe: Int16
    @NSManaged public var habatu: String?
    @NSManaged public var id: Int16
    @NSManaged public var rerity: Int16
    @NSManaged public var ikemenn: Bool
    @NSManaged public var megami: Bool
    @NSManaged public var name: String?
    @NSManaged public var nyannko: Bool
    @NSManaged public var powerPerSecond: Int32
    @NSManaged public var spcialEffect1: String?
    @NSManaged public var spcialEffect1_amount: Int16
    @NSManaged public var spcialEffect2: String?
    @NSManaged public var spcialEffect2_amount: Int16
    @NSManaged public var spcialEffect3: String?
    @NSManaged public var spcialEffect3_amount: Int16
    @NSManaged public var spcialEffect4: String?
    @NSManaged public var spcialEffect4_amount: Int16
    @NSManaged public var kakusei: Int16
    @NSManaged public var uuid: UUID?
    @NSManaged public var party: NSSet?

}

// MARK: Generated accessors for party
extension Character {

    @objc(addPartyObject:)
    @NSManaged public func addToParty(_ value: Party)

    @objc(removePartyObject:)
    @NSManaged public func removeFromParty(_ value: Party)

    @objc(addParty:)
    @NSManaged public func addToParty(_ values: NSSet)

    @objc(removeParty:)
    @NSManaged public func removeFromParty(_ values: NSSet)

}

extension Character : Identifiable {
    func specialEffectReplace (keyPath: ReferenceWritableKeyPath<Character,Optional<String>>, newEffect: String){
        self[keyPath: keyPath] = newEffect
    }
    func specialEffectAmountReplace (keyPath: ReferenceWritableKeyPath<Character,Int16>, newAmount: Int16){
        self[keyPath: keyPath] = newAmount
    }
}

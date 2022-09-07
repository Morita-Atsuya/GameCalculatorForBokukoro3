//
//  DouguTati+CoreDataClass.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData

@objc(DouguTati)
public class DouguTati: NSManagedObject {

}
extension DouguTati {
    func specialEffectCalculate(specialEffect: String)->Int{
        var specialEffectAmountInThisSet = 0
        for i in 1...self.douguArray.count{
            if douguArray[i-1].specialE == specialEffect {
                specialEffectAmountInThisSet += Int(douguArray[i-1].specialE_amount)
            }
        }
        
        return specialEffectAmountInThisSet
    }
}

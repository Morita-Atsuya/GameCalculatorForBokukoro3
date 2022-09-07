//
//  Character+CoreDataClass.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData

@objc(Character)
public class Character: NSManagedObject {

}
extension Character{
    func powerUpMe(party: Party)->Int{
        
        var powerUp = 0
        
        powerUp += bySelf()
        powerUp += byHabatu(party: party)
        powerUp += byAttackTipe(party: party)
        powerUp += byZokusei(party: party)
        powerUp += byRerity(party: party)
        
        powerUp += Int(self.kakusei)
    
        return powerUp
    }
    func bySelf()->Int{
        var powerUp = 0
        let specialEffectKeypathArray = [\Character.spcialEffect1,\Character.spcialEffect2,\Character.spcialEffect3,\Character.spcialEffect4]
        let specialEffectAmountKeypathArray = [\Character.spcialEffect1_amount,\Character.spcialEffect2_amount,\Character.spcialEffect3_amount,\Character.spcialEffect4_amount]
         
        for i in 0...3{
            if self[keyPath: specialEffectKeypathArray[i]] == SpecialEffect.forSelf.rawValue{
                powerUp += Int(self[keyPath: specialEffectAmountKeypathArray[i]])
            }
        }
        return powerUp
    }
    func byHabatu(party: Party)->Int{
        var powerUp = 0
        let habatuUp = "派閥　\(self.habatu ?? "")"
        powerUp += party.powerUpByCharacterCalculate(specialEffect: habatuUp)
        powerUp += party.dougutati?.specialEffectCalculate(specialEffect: habatuUp) ?? 0
        return powerUp
    }
    func byAttackTipe(party: Party)->Int{
        var powerUp = 0
        let attackTipeUp = "攻撃間隔　\(self.attackTipe)"
        powerUp += party.powerUpByCharacterCalculate(specialEffect: attackTipeUp)
        powerUp += party.dougutati?.specialEffectCalculate(specialEffect: attackTipeUp) ?? 0
        
        return powerUp
    }
    func byZokusei(party: Party)->Int{
        var powerUp = 0
        if !(self.ikemenn || self.megami || self.nyannko){
            powerUp += party.powerUpByCharacterCalculate(specialEffect: "属性　なし")
            powerUp += party.dougutati?.specialEffectCalculate(specialEffect: "属性　なし") ?? 0
        }else{
            if self.ikemenn{
                powerUp += party.powerUpByCharacterCalculate(specialEffect: "属性　イケメン")
                powerUp += party.dougutati?.specialEffectCalculate(specialEffect: "属性　イケメン") ?? 0
            }
            if self.megami{
                powerUp += party.powerUpByCharacterCalculate(specialEffect: "属性　女神")
                powerUp += party.dougutati?.specialEffectCalculate(specialEffect: "属性　女神") ?? 0
            }
            if self.nyannko{
                powerUp += party.powerUpByCharacterCalculate(specialEffect: "属性　にゃんこ")
                powerUp += party.dougutati?.specialEffectCalculate(specialEffect: "属性　にゃんこ") ?? 0
            }
        }
        return powerUp
    }
    func byRerity(party: Party)->Int{
        var powerUp = 0
        let rerityUp = "レア\(self.rerity)　UP"
        powerUp += party.powerUpByCharacterCalculate(specialEffect: rerityUp)
        powerUp += party.dougutati?.specialEffectCalculate(specialEffect: rerityUp) ?? 0
        
        return powerUp
    }
}

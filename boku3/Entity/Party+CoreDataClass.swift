//
//  Party+CoreDataClass.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Party)
public class Party: NSManagedObject {

}

extension Party {
    func specialEffectCalculateInThisParty(specialEffect: String)->Int{
        var specialEffectSum = 0
        specialEffectSum += powerUpByCharacterCalculate(specialEffect: specialEffect)
        specialEffectSum += powerUpByDouguTatiCalculate(specialEffect: specialEffect)
        return specialEffectSum
    }
}
extension Party{
    func powerUpByCharacterCalculate(specialEffect: String)->Int{
        var specialEffectAmountInThisCharacterArray = 0
        
        let specialEffectKeypathArray = [\Character.spcialEffect1,\Character.spcialEffect2,\Character.spcialEffect3,\Character.spcialEffect4]
        let specialEffectAmountKeypathArray = [\Character.spcialEffect1_amount,\Character.spcialEffect2_amount,\Character.spcialEffect3_amount,\Character.spcialEffect4_amount]
        for i in 1...minRequiredPartyMember{
            for n in 0...3{
                if self.characterArray[i-1][keyPath: specialEffectKeypathArray[n]] == specialEffect{
                specialEffectAmountInThisCharacterArray += Int(self.characterArray[i-1][keyPath: specialEffectAmountKeypathArray[n]])
                }
                if self.characterArray[i-1][keyPath: specialEffectKeypathArray[n]] == SpecialEffect.partyDepend_NotNormal_Normal.rawValue{
                    if specialEffect == SpecialEffect.tipe_3.rawValue{
                        var notNormalCounter = 0
                        for k in 1...6{
                            if self.characterArray[k-1].attackTipe != 3{
                                notNormalCounter += 1
                            }
                        }
                        specialEffectAmountInThisCharacterArray += notNormalCounter*Int(self.characterArray[i-1][keyPath: specialEffectAmountKeypathArray[n]])
                    }
                }
            }
        }
        return specialEffectAmountInThisCharacterArray
    }
    func powerUpByDouguTatiCalculate(specialEffect: String)->Int{
        var specialEffectAmountInThisDouguTatiArray = 0
        if let douguTati = self.dougutati{
            for i in 1...douguTati.douguArray.count{
                let dougu = douguTati.douguArray[i-1]
                if dougu.specialE == specialEffect{
                    specialEffectAmountInThisDouguTatiArray += Int(dougu.specialE_amount)
                }
                if dougu.powerUpForAll == specialEffect{
                    specialEffectAmountInThisDouguTatiArray += Int(dougu.powerUpForAllAmount)
                }
            }
        }
        return specialEffectAmountInThisDouguTatiArray
    }
}
extension Party{
    func maxDamageOfOneGame()->Int{
        var sumOfDamageByAllCharacterInThisParty = 0
        let defaultGameTime = 30
        let gameTime = defaultGameTime + self.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_time.rawValue)
        
        for index in 0...minRequiredPartyMember-1{
            let damageOfOneCharacterPerSecond = calculateDamageOfOneCharacterPerSecond(index: index)
            let numberOfAttacks = (gameTime-1)/Int(self.characterArray[index].attackTipe)
            let damageOfOneAttack = damageOfOneCharacterPerSecond*Int(self.characterArray[index].attackTipe)
            let sumOfDamageInThisGame = damageOfOneAttack*numberOfAttacks
            sumOfDamageByAllCharacterInThisParty += sumOfDamageInThisGame
        }

        
        sumOfDamageByAllCharacterInThisParty = Int(Double(sumOfDamageByAllCharacterInThisParty)*100/(100-Double(self.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.tehai_HP.rawValue))))
        
        return sumOfDamageByAllCharacterInThisParty
    }
    
    func calculateDamageOfOneCharacterPerSecond(index:Int)->Int{
        var powerPerSecontOfThisCharacter = Double(self.characterArray[index].powerPerSecond)
        powerPerSecontOfThisCharacter *= (1+Double(self.characterArray[index].powerUpMe(party: self))/100)
        powerPerSecontOfThisCharacter *= (1+Double(self.specialEffectCalculateInThisParty(specialEffect: SpecialEffect.forALL.rawValue))/100)
        
        return Int(powerPerSecontOfThisCharacter)
    }
    func defeatablLevelIndex()->Int{
        var levelIndex = 0
        let maxDamage = self.maxDamageOfOneGame()
        while maxDamage > levelData[levelIndex][1]*1000000{
            levelIndex += 1
        }
        if levelIndex == 0 {
            levelIndex += 1
        }
        return levelIndex-1
    }
}

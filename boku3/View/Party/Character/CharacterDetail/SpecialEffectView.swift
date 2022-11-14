//
//  SpecialEffect.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct SpecialEffectView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var character: Character
    @State private var isChange = false
    
    var body: some View {
        VStack{
            Text("特殊能力")
                .font(.title2)
            
            HStack{
                Text("①")
                SpecialEffectEditor(character: character, effectKeyPath: \Character.spcialEffect1, effectAmountKeyPath: \Character.spcialEffect1_amount)
            }
            HStack{
                Text("②")
                SpecialEffectEditor(character: character, effectKeyPath: \Character.spcialEffect2, effectAmountKeyPath: \Character.spcialEffect2_amount)
            }
            HStack{
                Text("③")
                SpecialEffectEditor(character: character, effectKeyPath: \Character.spcialEffect3, effectAmountKeyPath: \Character.spcialEffect3_amount)
            }
            HStack{
                Text("開眼")
                SpecialEffectEditor(character: character, effectKeyPath: \Character.spcialEffect4, effectAmountKeyPath: \Character.spcialEffect4_amount)
            }
            HStack{
                Text("覚醒")
                KakuseiEditor(character: character)
            }
            
        }
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct SpecialEffect_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffect()
    }
}
*/

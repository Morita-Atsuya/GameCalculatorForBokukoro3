//
//  SpecialEffectMaker.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct SpecialEffectEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEffectChange = false
    @State private var isEffectAmountChange = false
    @ObservedObject var character: Character
    var effectKeyPath: ReferenceWritableKeyPath<Character,Optional<String>>
    var effectAmountKeyPath: ReferenceWritableKeyPath<Character,Int16>
    @State private var newEffect: String = "new"
    @State private var newAmount: Int16 = 99
    
    var body: some View {
        HStack{
            if isEffectChange{
                Picker(selection: $newEffect, label:Text(newEffect)){
                    ForEach(SpecialEffect.allCases, id:\.self){effect in
                        Text(effect.rawValue).tag(effect.rawValue)
                    }
                }
                .font(.title)
                Button("OK"){
                    character.specialEffectReplace(keyPath: effectKeyPath, newEffect: newEffect)
                    save()
                    isEffectChange.toggle()
                }
                    .font(.title)
            }else{
                Toggle("\(character[keyPath: effectKeyPath] ?? "入力")", isOn: $isEffectChange)
                    .font(.title2)
                    .toggleStyle(.button)
                    .lineLimit(1)
            }
            
            Spacer()
            Text("効果量")
            
            if isEffectAmountChange{
                TextField("効果量（％）", value: $newAmount, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .font(.title)
                Button("OK"){
                    character.specialEffectAmountReplace(keyPath: effectAmountKeyPath, newAmount: newAmount)
                    save()
                    isEffectAmountChange.toggle()
                }
                    .font(.title)
            }else{
                Button("\(character[keyPath: effectAmountKeyPath])"){
                    newAmount = character[keyPath: effectAmountKeyPath]
                    isEffectAmountChange.toggle()
                }
            }
            Text("%")
        }
    }
    
    private func save(){
        try? viewContext.save()
    }
}

/*
struct SpecialEffectMaker_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectMaker()
    }
}
*/

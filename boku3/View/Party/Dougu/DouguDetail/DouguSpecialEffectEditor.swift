//
//  SpecialEffectEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/30.
//

import SwiftUI

struct DouguSpecialEffectEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isEffectChange = false
    @State private var isEffectAmountChange = false
    @ObservedObject var dougu: Dougu
    var effectKeyPath: ReferenceWritableKeyPath<Dougu,Optional<String>>
    var effectAmountKeyPath: ReferenceWritableKeyPath<Dougu,Int16>
    @State private var newEffect: String = SpecialEffect.kuuhaku.rawValue
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
                    dougu.specialEffectReplace(keyPath: effectKeyPath, newEffect: newEffect)
                    save()
                    isEffectChange.toggle()
                }
                    .font(.title)
            }else{
                Toggle("\(dougu[keyPath: effectKeyPath] ?? SpecialEffect.kuuhaku.rawValue)", isOn: $isEffectChange)
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
                    dougu.specialEffectAmountReplace(keyPath: effectAmountKeyPath, newAmount: newAmount)
                    save()
                    isEffectAmountChange.toggle()
                }
                    .font(.title)
            }else{
                Button("\(dougu[keyPath: effectAmountKeyPath])"){
                    newAmount = dougu[keyPath: effectAmountKeyPath]
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
struct SpecialEffectEditor_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectEditor()
    }
}
*/

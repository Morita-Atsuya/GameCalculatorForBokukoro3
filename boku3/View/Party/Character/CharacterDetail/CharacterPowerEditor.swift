//
//  CharacterPowerEditer.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct CharacterPowerEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPowerChange = false
    @State private var isTipeChange = false
    @ObservedObject var character: Character
    @State private var powerPerSecond: Double = 1
    @State private var attackTipe: Int16 = 1
    
    init(character: Character){
        self.character = character
        _powerPerSecond = State(initialValue: Double(character.powerPerSecond)/10000)//表示桁数調整
        _attackTipe = State(initialValue: character.attackTipe)
    }
    
    var body: some View {
        HStack{
            Text("攻撃力")
                .font(.title2)
            
        if isPowerChange {
                TextField("攻撃力", value: $powerPerSecond, format: .number.precision(.fractionLength(2)))
                .keyboardType(.decimalPad)
                .disableAutocorrection(true)
                .font(.title)
                Button("OK"){
                    character.powerPerSecond = Int32(powerPerSecond*10000)
                    save()
                    isPowerChange.toggle()
                }
                    .font(.title)
        }else{
            Toggle(String(format: "%.2f",powerPerSecond), isOn: $isPowerChange)
                .font(.title)
                .toggleStyle(.button)
        }
            Text("万")
                .font(.title2)
            Spacer()
            Text("攻撃間隔")
                .font(.title2)
            
            if isTipeChange {
            Picker(selection: $attackTipe, label:Text("攻撃型")){
                Text("スピード").tag(Int16(1))
                Text("ノーマル").tag(Int16(3))
                Text("パワー").tag(Int16(5))
                Text("超パワー").tag(Int16(8))
            }
            .font(.title)
            Button("OK"){
                character.attackTipe = attackTipe
                save()
                isTipeChange.toggle()
            }
                .font(.title)
            } else {
                Toggle("\(attackTipe)", isOn: $isTipeChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
            Text("秒")
                .font(.title2)
        }
    }
    private func save(){
        try? viewContext.save()
    }
}


/*
struct CharacterPowerEditor_Previews: PreviewProvider {
    static var previews: some View {
        CharacterPowerEditor()
    }
}
*/

//
//  KakuseiEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/29.
//

import SwiftUI

struct KakuseiEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var character: Character
    @State private var isChange = false
    @State private var newValue:Int16 = 99
    
    init(character: Character){
        self.character = character
        _newValue = State(initialValue: character.kakusei)
    }
    
    var body: some View {
        Spacer()
        if isChange {
            TextField("上昇量（％）", value: $newValue, formatter: NumberFormatter())
            .keyboardType(.numberPad)
            .disableAutocorrection(true)
            .font(.title)
            .padding()
            Button("OK"){
                character.kakusei = newValue
                save()
                isChange.toggle()
            }
                .font(.title)
        }else{
            Toggle("\(character.kakusei)", isOn: $isChange)
                .font(.title)
                .toggleStyle(.button)
        }
        
        Text("%")
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct KakuseiEditor_Previews: PreviewProvider {
    static var previews: some View {
        KakuseiEditor()
    }
}
*/

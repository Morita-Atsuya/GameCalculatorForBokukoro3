//
//  CharacterName Editer.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct CharacterNameEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isNameChange = false
    @State private var isRerityChange = false
    @ObservedObject var character: Character
    @State private var name :String
    @State private var rerity: Int16
    
    init(character: Character){
        self.character = character
        _name = State(initialValue: character.name ?? "調整用")
        _rerity = State(initialValue: character.rerity)
    }
    
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
            if isRerityChange {
                Picker(selection: $rerity, label: Text("")){
                    Text("4").tag(Int16(4))
                    Text("3").tag(Int16(3))
                    Text("2").tag(Int16(2))
                    Text("1").tag(Int16(1))
                }
                .font(.title)
                Button("OK"){
                    character.rerity = rerity
                    save()
                    isRerityChange.toggle()
                }
                    .font(.title)
            }else{
                Toggle("\(rerity)", isOn: $isRerityChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
            
            if isNameChange {
                TextField("キャラクター名",text: $name)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250)
                                .padding()
                                .font(.title)
                Button("OK"){
                    character.name = name
                    save()
                    isNameChange.toggle()
                }
                    .font(.title)
            }else{
                Toggle("\(name)", isOn: $isNameChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
        }
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct CharacterName_Editer_Previews: PreviewProvider {
    static var previews: some View {
        CharacterNameEditor()
    }
}
*/

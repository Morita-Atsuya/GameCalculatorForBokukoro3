//
//  Habatyu.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/28.
//

import SwiftUI

struct HabatuPicker: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isChange = false
    @ObservedObject var character: Character
    @State private var habatu :String = "エジプト"
    
    init(character: Character){
        self.character = character
        _habatu = State(initialValue: character.habatu!)
    }
    
    var body: some View {
        HStack{
            Text("派閥")
                .font(.title2)
            Spacer()
            
            if isChange {
            Picker(selection: $habatu, label:Text(habatu)){
                Text("エジプト").tag("エジプト")
                Text("旧支配").tag("旧支配")
                Text("ギリシャ").tag("ギリシャ")
                Text("独立").tag("独立")
            }
            .font(.title)
            Button("OK"){
                character.habatu = habatu
                save()
                isChange.toggle()
            }
                .font(.title)
            } else {
                Toggle("\(habatu)", isOn: $isChange)
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
struct Habatyu_Previews: PreviewProvider {
    static var previews: some View {
        Habatyu()
    }
}
*/

//
//  DouguNameEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/30.
//

import SwiftUI

struct DouguNameEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isNameChange = false
    @ObservedObject var dougu: Dougu
    @State private var name :String
    
    init(dougu: Dougu){
        self.dougu = dougu
        _name = State(initialValue: dougu.name ?? "調整用")
    }
    
    var body: some View {
        if isNameChange {
            TextField("道具名",text: $name)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250)
                            .padding()
                            .font(.title)
            Button("OK"){
                dougu.name = name
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
    private func save(){
        try? viewContext.save()
    }
}

/*
struct DouguNameEditor_Previews: PreviewProvider {
    static var previews: some View {
        DouguNameEditor()
    }
}
*/

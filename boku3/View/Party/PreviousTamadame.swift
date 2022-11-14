//
//  PreviousTamadame.swift
//  boku3
//
//  Created by 森田敦也 on 2022/09/25.
//
/*
import SwiftUI

struct PreviousTamadame: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isChange = false
    @ObservedObject var party: Party
    @State private var tamadame :Int16 = 0
    
    init(party: Party,tamadame: Int16){
        self.party = party
        self.tamadame = tamadame
    }
    
    var body: some View {
        HStack{
            Text("前回の与えた玉ダメ :")
            
            if isChange{
                TextField("ダメージ量", value: $tamadame, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .font(.title)
                Button("OK"){
                    party.previousTamadame = tamadame
                    save()
                    isChange.toggle()
                }
            }else{
                Toggle("\(tamadame)", isOn: $isChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
            
            Text("万")
        }
    }
    private func save(){
        try? viewContext.save()
    }
}


*/

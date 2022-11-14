//
//  CharacterDetail.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/15.
//

import SwiftUI
import CoreData

struct CharacterDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var character: Character
    
    var body: some View {
        VStack{
            
            CharacterNameEditor(character: character)
            HabatuPicker(character: character)
            ZokuseiButton(character: character)
            CharacterPowerEditor(character: character)
            SpecialEffectView(character: character)
            
        }
        .navigationTitle("Character")
        .navigationBarTitleDisplayMode(.inline)
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail()
    }
}
*/

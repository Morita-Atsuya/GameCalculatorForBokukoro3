//
//  CharacterPicker.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/27.
//

import SwiftUI
import CoreData

struct CharacterPicker: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @FetchRequest(
        entity: Character.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Character.id, ascending: true)],
        animation: .default
    ) private var fetchedCharacterList: FetchedResults<Character>
    var party: Party
    var character: Character
    
    var body: some View {
        List{
            ForEach(fetchedCharacterList){willAddCharacter in
                if !party.characterArray.contains(willAddCharacter){
                    Button(willAddCharacter.name!){
                        party.addToCharacter(willAddCharacter)
                        party.removeFromCharacter(character)
                        try? viewContext.save()
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
            Button("最大化"){
                maximizePartyAttacks()
            }
        }
        .navigationTitle("Character Choose")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension CharacterPicker{
    func maximizePartyAttacks(){
        var maxAttack = 0
        var maximizeCharacter: Character? = nil
        party.removeFromCharacter(character)
        fetchedCharacterList.forEach{character in
            if !party.characterArray.contains(character){
                party.addToCharacter(character)
                if maxAttack < party.maxDamageOfOneGame(){
                    maxAttack = party.maxDamageOfOneGame()
                    maximizeCharacter = character
                }
                party.removeFromCharacter(character)
            }
        }
        party.addToCharacter(maximizeCharacter!)
        
        try? viewContext.save()
        presentation.wrappedValue.dismiss()
    }
}

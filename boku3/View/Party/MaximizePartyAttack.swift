//
//  MaximizePartyAttack.swift
//  boku3
//
//  Created by 森田敦也 on 2022/09/07.
//

import SwiftUI

struct MaximizePartyAttack: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @FetchRequest(
        entity: Character.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Character.id, ascending: true)],
        animation: .default
    ) private var fetchedCharacterList: FetchedResults<Character>
    @ObservedObject var party: Party
    @State private var selectionValues: Set<Int> = []
    
    var body: some View {
        VStack{
            List(selection: $selectionValues){
                ForEach(0..<6){index in
                    Text(party.characterArray[index].name!).tag(index)
                }
            }
            .environment(\.editMode, .constant(.active))
            
            Button("OK"){
                maximizePartyAttack()
                try? viewContext.save()
                presentation.wrappedValue.dismiss()
            }
        }
    }
    private func maximizePartyAttack(){
        let sortedIndex = selectionValues.sorted(by: >)
        var maxAttack = 0
        var maximizeCharacterArray :[Character] = []
        var currentCharacterArray :[Character] = []
        var characterCandidateList :[Character] = []
        fetchedCharacterList.forEach{characterCandidateList.append($0)}
        
        sortedIndex.forEach{index in
            party.removeFromCharacter(party.characterArray[index])
        }
        party.characterArray.forEach{removeCharacter in
        characterCandidateList.removeAll(where: {$0 == removeCharacter})
        }
            
        addCharacter(startIndex:0)
        maximizeCharacterArray.forEach { character in
            party.addToCharacter(character)
        }
        
        func addCharacter(startIndex:Int){
            if party.characterArray.count < minRequiredPartyMember{
                let numberOfRequiredCharacter = minRequiredPartyMember-party.characterArray.count
                for i in startIndex...characterCandidateList.count-numberOfRequiredCharacter{
                    if !party.characterArray.contains(characterCandidateList[i]){
                        party.addToCharacter(characterCandidateList[i])
                        currentCharacterArray.append(characterCandidateList[i])
                        addCharacter(startIndex:i+1)
                        party.removeFromCharacter(characterCandidateList[i])
                        currentCharacterArray.removeAll(where: {$0 == characterCandidateList[i]})
                    }
                }
            }else{
                if maxAttack < party.maxDamageOfOneGame(){
                    maxAttack = party.maxDamageOfOneGame()
                    maximizeCharacterArray = currentCharacterArray
                }
            }
        }
    }
    
}



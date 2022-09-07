//
//  CharacterList.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/15.
//

import SwiftUI
import CoreData

struct CharacterList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Character.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Character.id, ascending: true)],
        animation: .default
    ) private var fetchedCharacterList: FetchedResults<Character>
    var body: some View {
            List{
                ForEach(fetchedCharacterList) { character in
                        NavigationLink{
                        CharacterDetail(character: character)
                        }label:{
                            HStack{
                                Text(character.name!)
                                Text("id:\(character.id)")
                                    .foregroundColor(.blue)
                            }
                    }
                }
                .onDelete(perform: removeRow)
                .onMove(perform: moveRow)
            }
            
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    Button("add"){
                        addNewCharacter()
                    }
                    EditButton()
                }
            }
             
            .navigationTitle("Character List")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    private func removeRow(offsets: IndexSet) {
        offsets.forEach { index in
                    viewContext.delete(fetchedCharacterList[index])
                }
        let numberOfCharacter = fetchedCharacterList.count
        if offsets.first! != numberOfCharacter-1 {
            for id in offsets.first!...numberOfCharacter-1 {
                fetchedCharacterList[id].id -= Int16(1)
            }
        }
        try? viewContext.save()
    }
    
    private func moveRow(offsets: IndexSet, to: Int) {
        let temporaryID = Int16(-1)
        let forReverse = offsets.first! + to
        if offsets.first! > to {
            fetchedCharacterList[offsets.first!].id = temporaryID
            for id in to...offsets.first!-1{
                fetchedCharacterList[forReverse-id-1].id += Int16(1)
            }
            fetchedCharacterList[offsets.first!].id = Int16(to)
        }else if offsets.first! < to {
            fetchedCharacterList[offsets.first!].id = temporaryID
            for id in offsets.first!+1...to-1{
                fetchedCharacterList[id].id -= Int16(1)
            }
            fetchedCharacterList[offsets.first!].id = Int16(to-1)
        }
        try? viewContext.save()
    }
    private func addNewCharacter(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Character.entity()
        let character = try! viewContext.fetch(fetchRequest) as! [Character]
        let numberOfCharacter = character.count
        let newCharacter = Character(context: viewContext)
        newCharacter.name = "新しい名前を入力"
        newCharacter.id = Int16(numberOfCharacter)
        newCharacter.powerPerSecond = 1
        newCharacter.attackTipe = 1
        newCharacter.rerity = 4
        newCharacter.habatu = "エジプト"
        newCharacter.nyannko = false
        newCharacter.ikemenn = false
        newCharacter.megami = false
        try? viewContext.save()
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            
    }
}



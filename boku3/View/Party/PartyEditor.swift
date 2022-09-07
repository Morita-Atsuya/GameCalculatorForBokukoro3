//
//  PartyEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/14.
//

import SwiftUI
import CoreData

struct PartyEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var newName: String = "new party Name"
    
    var body: some View {
        VStack{
            Text("新しいパーティ")
                .padding()
            Text("現在の名前:\(newName)")
            TextField("パーティ名",text: $newName)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                                .padding()
            Button(action:{addParty(context: viewContext)}) {
                Text("追加")
            }
        }
    }
    private func addParty(context: NSManagedObjectContext){
        let fetchRequestParty = NSFetchRequest<NSFetchRequestResult>()
        let fetchRequestCharacter = NSFetchRequest<NSFetchRequestResult>()
        fetchRequestParty.entity = Party.entity()
        fetchRequestCharacter.entity = Character.entity()
        let party = try! context.fetch(fetchRequestParty) as! [Party]
        let character = try! context.fetch(fetchRequestCharacter) as! [Character]
        let numberOfPartys = party.count
        //let characterCount = character.count
        let newParty = Party(context: viewContext)
        newParty.name = newName
        newParty.id = Int16(numberOfPartys)
        for i in 1...minRequiredPartyMember {
            newParty.addToCharacter(character[i-1])
        }
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()

    }
}

struct PartyEditor_Previews: PreviewProvider {
    static var previews: some View {
        PartyEditor()
    }
}

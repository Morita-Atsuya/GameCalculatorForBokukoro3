//
//  CharacterEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/15.
//

import SwiftUI
import CoreData

struct CharacterEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var newName: String = "newName"
    
    var body: some View {
        VStack{
            Text("現在の名前\(newName)")
            TextField("キャラクター名",text: $newName)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .padding()
            Button(action:{addCharacter(context: viewContext)}) {
                Text("追加")
            }
        }
    }
    private func addCharacter(context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Character.entity()
        let character = try! context.fetch(fetchRequest) as! [Character]
        let numberOfCharacter = character.count
        let newCharacter = Character(context: context)
        newCharacter.name = newName
        newCharacter.id = Int16(numberOfCharacter)
        newCharacter.powerPerSecond = 1
        newCharacter.attackTipe = 1
        newCharacter.rerity = 4
        newCharacter.habatu = "エジプト"
        newCharacter.nyannko = false
        newCharacter.ikemenn = false
        newCharacter.megami = false
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()

    }
}

/*
struct CharacterEditor_Previews: PreviewProvider {
    static var previews: some View {
        CharacterEditor()
    }
}
*/

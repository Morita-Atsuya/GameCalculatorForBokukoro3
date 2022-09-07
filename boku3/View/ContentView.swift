//
//  ContentView.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/12.
//

import SwiftUI
import CoreData
public let minRequiredPartyMember = 6
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        MainMenu()
            .onAppear{
                registDefaulteCharacterData(context: viewContext)
                registDefaulteDouguData(context: viewContext)
                characterIDInitialize (context: viewContext)
                
            }
    }
}
func registDefaulteCharacterData (context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = Character.entity()
    let character = try? context.fetch(fetchRequest) as? [Character]
    var characterCount = character?.count ?? 0
    //print(characterCount)
    while characterCount < minRequiredPartyMember {
        let newCharacter = Character(context: context)
        newCharacter.id = Int16(characterCount)
        newCharacter.name = "defailt　name id:\(newCharacter.id)"
        newCharacter.powerPerSecond = 1
        newCharacter.attackTipe = 1
        newCharacter.rerity = Int16(4)
        newCharacter.habatu = "エジプト"
        newCharacter.nyannko = false
        newCharacter.ikemenn = false
        newCharacter.megami = false
        characterCount += 1
        //print("newCharacter:\(newCharacter)")
        try? context.save()
    }
    //後でidの初期化する
}
func registDefaulteDouguData (context: NSManagedObjectContext) {
    let douguCount = numberOfEntity(entity: "Dougu", context: context)
    if douguCount == 0 {
        let newDougu = Dougu(context: context)
        newDougu.id = 0
        newDougu.name = "defailt　name id:\(newDougu.id)"
        try? context.save()
    }
}

func characterIDInitialize (context: NSManagedObjectContext){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = Character.entity()
    let character = try! context.fetch(fetchRequest) as! [Character]
    let characterCount = character.count
    for id in 0...characterCount-1 {
        character[id].id = Int16(id)
       // print(id)
    }
}

func numberOfEntity(entity: String, context: NSManagedObjectContext)->Int{
    let request = NSFetchRequest<NSFetchRequestResult>()
     request.entity = NSEntityDescription.entity(forEntityName: entity, in: context)
     request.includesSubentities = false
    
    do {
    let count = try context.count(for: request)
    return count
    } catch _ as NSError {
        print("おい")
        return 0
    }
}

//
//  PartyList.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/12.
//


import SwiftUI
import CoreData

struct MainMenu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Party.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Party.id, ascending: true)],
        animation: .default
    ) private var fetchedPartyList: FetchedResults<Party>
    @FetchRequest(
        entity: DouguTati.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DouguTati.id, ascending: true)],
        animation: .default
    ) private var fetchedDouguTatiList: FetchedResults<DouguTati>
    @State private var isCopyMode = false
    
    var body: some View {
        NavigationView{
            List{
                Section(header:Text("Party List")){
                ForEach(fetchedPartyList){ party in
        
                    if isCopyMode {
                        Button(party.name ?? "なんかダメ"){
                       copyParty(party: party)
                    }
                    }else{
                     
                    NavigationLink{
                        PartyDetail(party: party)
                    }label:{
                        HStack{
                            Text(party.name ?? "")
                            Spacer()
                            Text("\(levelData[party.defeatablLevelIndex()][0])Lv")
                        }
                    }
                    }
                }
                .onDelete(perform: removeParty)
                .onMove(perform: moveParty)
                }
                
                Section(header:Text("Dougu Set List")){
                ForEach(fetchedDouguTatiList){ douguTati in
        
                    if isCopyMode {
                        Button(douguTati.name ?? "なんかダメ"){
                       copyDouguTati(douguTati: douguTati)
                    }
                    }else{
                     
                    NavigationLink{
                        DouguTatiDetail(douguTati: douguTati)
                    }label:{
                        HStack{
                            Text(douguTati.name ?? "")
                            Text("id:\(douguTati.id)")
                        }
                    }
                    }
                }
                .onDelete(perform: removeDouguTati)
                .onMove(perform: moveDouguTati)
                }
                
                Section{
                    NavigationLink("Character List"){
                        CharacterList()
                    }
                
                    NavigationLink("Artifact List"){
                        DouguList()
                    }
                }

            }
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing){
                    NavigationLink("Add"){
                        PartyOrDouguTatiEditor()
                            .navigationTitle("add")
                    }
                    Toggle("Copy", isOn: $isCopyMode)
                    EditButton()
                }
            }
            .navigationTitle("Main")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    private func removeParty(offsets: IndexSet) {
        offsets.forEach { index in
                    viewContext.delete(fetchedPartyList[index])
                }
        let numberOfParty = fetchedPartyList.count
        if offsets.first! != numberOfParty-1 {
            for id in offsets.first!...numberOfParty-1 {
                fetchedPartyList[id].id -= Int16(1)
            }
        }
        try? viewContext.save()
    }
    private func removeDouguTati(offsets: IndexSet) {
        offsets.forEach { index in
                    viewContext.delete(fetchedDouguTatiList[index])
                }
        let numberOfParty = fetchedDouguTatiList.count
        if offsets.first! != numberOfParty-1 {
            for id in offsets.first!...numberOfParty-1 {
                fetchedDouguTatiList[id].id -= Int16(1)
            }
        }
        try? viewContext.save()
    }
   
    private func moveParty(offsets: IndexSet, to: Int) {
        let temporaryID = Int16(-1)
        let forReverse = offsets.first! + to
        if offsets.first! > to {
            fetchedPartyList[offsets.first!].id = temporaryID
            for id in to...offsets.first!-1{
                fetchedPartyList[forReverse-id-1].id += Int16(1)
            }
            fetchedPartyList[offsets.first!].id = Int16(to)
        }else if offsets.first! < to {
            fetchedPartyList[offsets.first!].id = temporaryID
            for id in offsets.first!+1...to-1{
                fetchedPartyList[id].id -= Int16(1)
            }
            fetchedPartyList[offsets.first!].id = Int16(to-1)
        }
        try? viewContext.save()
    }
    private func moveDouguTati(offsets: IndexSet, to: Int) {
        let temporaryID = Int16(-1)
        let forReverse = offsets.first! + to
        if offsets.first! > to {
            fetchedDouguTatiList[offsets.first!].id = temporaryID
            for id in to...offsets.first!-1{
                fetchedDouguTatiList[forReverse-id-1].id += Int16(1)
            }
            fetchedDouguTatiList[offsets.first!].id = Int16(to)
        }else if offsets.first! < to {
            fetchedDouguTatiList[offsets.first!].id = temporaryID
            for id in offsets.first!+1...to-1{
                fetchedDouguTatiList[id].id -= Int16(1)
            }
            fetchedDouguTatiList[offsets.first!].id = Int16(to-1)
        }
        try? viewContext.save()
    }
    
    private func copyParty (party: Party){
        let newParty = Party(context: viewContext)
        newParty.name = "\(party.name ?? "おかしいぞ")のコピー"
        newParty.character = party.character
        newParty.dougutati = party.dougutati
        newParty.id = Int16(fetchedPartyList.count)
        try? viewContext.save()
    }
    private func copyDouguTati (douguTati: DouguTati){
        let newDouguTati = DouguTati(context: viewContext)
        newDouguTati.name = "\(douguTati.name ?? "おかしいぞ")のコピー"
        newDouguTati.dougu = douguTati.dougu
        newDouguTati.id = Int16(fetchedDouguTatiList.count)
        try? viewContext.save()
    }
    /*
    private func partyIDInitialize (context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Party.entity()
        let party = try! context.fetch(fetchRequest) as! [Party]
        let partyCount = party.count
        for id in 0...partyCount-1 {
            party[id].id = Int16(id)
           // print(id)
        }
        try? viewContext.save()
    }
    */
    
    
}


/*
struct PartyList_Previews: PreviewProvider {
    static var previews: some View {
        PartyList()
            
    }
}
*/

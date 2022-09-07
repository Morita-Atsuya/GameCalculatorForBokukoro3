//
//  DouguList.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/29.
//

import SwiftUI
import CoreData

struct DouguList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Dougu.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Dougu.id, ascending: true)],
        animation: .default
    ) private var fetchedDouguList: FetchedResults<Dougu>
    
    var body: some View {
        List{
            ForEach(fetchedDouguList) { dougu in
                    NavigationLink{
                        DouguDetail(dougu: dougu)
                    }label:{
                        HStack{
                            Text(dougu.name!)
                            Text("id:\(dougu.id)")
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
                    addNewDougu()
                }
                EditButton()
            }
        }
         
        .navigationTitle("Dougu List")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    private func removeRow(offsets: IndexSet) {
        offsets.forEach { index in
                    viewContext.delete(fetchedDouguList[index])
                }
        let numberOfCharacter = fetchedDouguList.count
        if offsets.first! != numberOfCharacter-1 {
            for id in offsets.first!...numberOfCharacter-1 {
                fetchedDouguList[id].id -= Int16(1)
            }
        }
        try? viewContext.save()
    }
    
    private func moveRow(offsets: IndexSet, to: Int) {
        let temporaryID = Int16(-1)
        let forReverse = offsets.first! + to
        if offsets.first! > to {
            fetchedDouguList[offsets.first!].id = temporaryID
            for id in to...offsets.first!-1{
                fetchedDouguList[forReverse-id-1].id += Int16(1)
            }
            fetchedDouguList[offsets.first!].id = Int16(to)
        }else if offsets.first! < to {
            fetchedDouguList[offsets.first!].id = temporaryID
            for id in offsets.first!+1...to-1{
                fetchedDouguList[id].id -= Int16(1)
            }
            fetchedDouguList[offsets.first!].id = Int16(to-1)
        }
        try? viewContext.save()
    }
    private func addNewDougu(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Dougu.entity()
        let dougu = try! viewContext.fetch(fetchRequest) as! [Dougu]
        let numberOfDougu = dougu.count
        let newDougu = Dougu(context: viewContext)
        newDougu.name = "新しい名前"
        newDougu.id = Int16(numberOfDougu)
        newDougu.powerUpForAllAmount = 4
        newDougu.powerUpForAll = SpecialEffect.forALL.rawValue
        
        try? viewContext.save()
    
    }
}

/*
struct DouguList_Previews: PreviewProvider {
    static var previews: some View {
        DouguList()
    }
}
*/

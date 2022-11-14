//
//  DouguTatiDetail.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/31.
//

import SwiftUI

struct DouguTatiDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Dougu.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Dougu.id, ascending: false)],
        animation: .default
    ) var fetchedDouguList: FetchedResults<Dougu>
    @State private var isNameChange = false
    @ObservedObject private var douguTati: DouguTati
    @State private var name :String
    
    
    init(douguTati: DouguTati){
        self.douguTati = douguTati
        _name = State(initialValue: douguTati.name ?? "調整用")
       
    }
    
    
    var body: some View {
        VStack{
            if isNameChange {
                HStack{
                    TextField("道具名",text: $name)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                                    .padding()
                    .font(.title)
                    Button("OK"){
                        douguTati.name = name
                        save()
                        isNameChange.toggle()
                    }
                        .font(.title)
                      
                }
            }else{
                Toggle("\(name)", isOn: $isNameChange)
                    .font(.title)
                    .toggleStyle(.button)
            }
            Form{
                ForEach(0..<douguTati.douguArray.count, id:\.self){id in
                    HStack{
                        Text(douguTati.douguArray[id].name ?? "誰やねん")
                        NavigationLink(""){
                            DouguPicker(douguTati: douguTati, dougu: douguTati.douguArray[id])
                        }
                    }
                    .swipeActions(edge: .trailing){
                        Button() {
                            douguTati.removeFromDougu(douguTati.douguArray[id])
                                                } label: {
                                                    Image(systemName: "trash.fill")
                                                }.tint(.red)
                    }
                }
            }
            //.frame(height: 400)
        }
        .toolbar {
            ToolbarItemGroup(placement:.navigationBarTrailing){
                NavigationLink("Add"){
                    DouguPicker(douguTati: douguTati, dougu:nil)
                        .navigationTitle("add")
                }
            }
        }
        .navigationTitle("道具デッキ")
        .navigationBarTitleDisplayMode(.inline)
    }
    private func save(){
        try? viewContext.save()
    }

}


/*
struct DouguTatiDetail_Previews: PreviewProvider {
    static var previews: some View {
        DouguTatiDetail()
    }
}
*/

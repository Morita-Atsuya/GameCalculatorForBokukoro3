//
//  DouguTatiEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/31.
//

import SwiftUI
import CoreData

struct DouguTatiEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var newName: String = "new deck name"
    
    var body: some View {
        VStack{
            Text("新しいデッキ")
                .padding()
            Text("現在の名前:\(newName)")
            TextField("道具デッキ名",text: $newName)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                                .padding()
            Button("追加") {
                addNewDouguTati()
            }
        }
    }
    private func addNewDouguTati(){
        let fetchRequestDougu = NSFetchRequest<NSFetchRequestResult>(entityName: "Dougu")
        let douguTati = try! viewContext.fetch(fetchRequestDougu) as! [Dougu]
        let newDouguTati = DouguTati(context: viewContext)
        newDouguTati.name = newName
        newDouguTati.id = Int16(numberOfEntity(entity: "DouguTati", context: viewContext))
        newDouguTati.addToDougu(douguTati[0])
        
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()
    }
    
}

/*
struct DouguTatiEditor_Previews: PreviewProvider {
    static var previews: some View {
        DouguTatiEditor()
    }
}
*/

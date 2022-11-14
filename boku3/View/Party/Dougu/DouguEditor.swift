//
//  DouguEditor.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/29.
//
/*
import SwiftUI
import CoreData

struct DouguEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var newName: String = "newName"
    
    var body: some View {
        VStack{
            Text("現在の名前\(newName)")
            TextField("道具名",text: $newName)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .padding()
            Button(action:{addDougu(context: viewContext)}) {
                Text("追加")
            }
        }
    }
    private func addDougu(context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = Dougu.entity()
        let dougu = try! context.fetch(fetchRequest) as! [Dougu]
        let numberOfDougu = dougu.count
        let newDougu = Dougu(context: context)
        newDougu.name = newName
        newDougu.id = Int16(numberOfDougu)
        
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()
    }
}
*/
/*
struct DouguEditor_Previews: PreviewProvider {
    static var previews: some View {
        DouguEditor()
    }
}
*/

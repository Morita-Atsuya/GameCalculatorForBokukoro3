//
//  DouguTatiPicker.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/31.
//

import SwiftUI
import CoreData

struct DouguTatiPicker: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @FetchRequest(
        entity: DouguTati.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DouguTati.id, ascending: true)],
        animation: .default
    ) private var fetchedDouguTatiList: FetchedResults<DouguTati>
    @ObservedObject var party: Party
    
    
    
    var body: some View {
       
        List{
            ForEach(fetchedDouguTatiList){willAddDouguTati in
                Button(willAddDouguTati.name!){
                    party.dougutati = willAddDouguTati
                        try? viewContext.save()
                        presentation.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Dougu Choose")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct DouguTatiPicker_Previews: PreviewProvider {
    static var previews: some View {
        DouguTatiPicker()
    }
}
*/

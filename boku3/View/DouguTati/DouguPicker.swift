//
//  DouguPicker.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/31.
//

import SwiftUI
import CoreData

struct DouguPicker: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @FetchRequest(
        entity: Dougu.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Dougu.id, ascending: true)],
        animation: .default
    ) private var fetchedDouguList: FetchedResults<Dougu>
    var douguTati: DouguTati
    var dougu: Dougu?

    var body: some View {
        List{
            ForEach(fetchedDouguList){willAddDougu in
                if !douguTati.douguArray.contains(willAddDougu) {
                    Button(willAddDougu.name!){
                        douguTati.addToDougu(willAddDougu)
                        if let dougu = dougu {
                            douguTati.removeFromDougu(dougu)
                        }
                        try? viewContext.save()
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationTitle("Dougu Choose")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
struct DouguPicker_Previews: PreviewProvider {
    static var previews: some View {
        DouguPicker()
    }
}
*/

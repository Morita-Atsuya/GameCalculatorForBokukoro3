//
//  DouguDetail.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/29.
//

import SwiftUI
import CoreData

struct DouguDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dougu: Dougu
    
    var body: some View {
        VStack{
            DouguNameEditor(dougu: dougu)
            DouguSpecialEffectView(dougu: dougu)
        }
        .navigationTitle("道具")
        .navigationBarTitleDisplayMode(.inline)
    }
    private func save(){
        try? viewContext.save()
    }
}

/*
struct DouguDetail_Previews: PreviewProvider {
    static var previews: some View {
        DouguDetail()
    }
}
*/

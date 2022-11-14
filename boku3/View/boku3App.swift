//
//  boku3App.swift
//  boku3
//
//  Created by 森田敦也 on 2022/08/12.
//

import SwiftUI

@main
struct boku3App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

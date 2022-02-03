//
//  PainControlApp.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import SwiftUI

@main
struct PainControlApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

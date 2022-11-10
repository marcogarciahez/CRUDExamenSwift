//
//  CRUDExamenMobiliarioApp.swift
//  CRUDExamenMobiliario
//
//  Created by Roberto Marco García Hernández on 10/11/22.
//

import SwiftUI

@main
struct CRUDExamenMobiliarioApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

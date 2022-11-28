//
//  CRUDExamenMobiliarioApp.swift
//  CRUDExamenMobiliario
//
//  Created by Roberto Marco García Hernández on 10/11/22.
//

import SwiftUI

@main
struct CRUDExamenMobiliarioApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}

//
//  Devote_CoreData_CRUDApp.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 19/12/23.
//

import SwiftUI

@main
struct Devote_CoreData_CRUDApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

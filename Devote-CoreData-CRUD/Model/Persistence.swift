//
//  Persistence.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 19/12/23.
//

import CoreData

struct PersistenceController {
    // MARK: - Persistence Controller
    static let shared = PersistenceController()

    // MARK: - Persistent Container
    let container: NSPersistentContainer

    // MARK: - Load the Persistent store
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote_CoreData_CRUD")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    // MARK: - Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task no \(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}

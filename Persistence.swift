//
//  Persistence.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        for _ in 0..<10 {
            let drug = Drug(context: viewContext)
            drug.name = "Ibu"
            drug.dose = "600mg"
            drug.morning = false
            drug.noon = true
            drug.evening = false
            drug.night = true
            drug.created = Date()
            drug.edit = Date()
        }
        for _ in 0..<10 {
            let inTake = InTake(context: viewContext)
            inTake.drugName = "Tillidin"
            inTake.pain = Int16(5)
            inTake.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PainControl")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
 
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}

//
//  PainControlWidget.swift
//  PainControlWidget
//
//  Created by Frederik Kohler on 05.02.22.
//

import WidgetKit
import SwiftUI
import CoreData


class CoreDataManager {



}


struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        //let managedObjectContext = PersistenceController.shared.managedObjectContext

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct PainControlWidgetEntryView : View {
    var entry: Provider.Entry
    
    /*
     let moc = PersistenceController.shared.container.viewContext
     
     let predicate = NSPredicate(format: "attribute1 == %@", "test")
     let request = NSFetchRequest<Drug>(entityName: "Drug")
     let result = try moc.fetch(request)
     */
    
    var body: some View {
        ZStack{
            
            LinearGradient(
                colors: [Color("darkBlue"),Color("lightBlue")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            HStack{
                Image("AppIcon")
                    .resizable()
                    .frame(height: 50)
                Button("IBU"){}
                .font(.subheadline)
                .foregroundColor(.white)
            }
        }
    }
}

class PersistenceController {
    static let shared = PersistenceController()
    
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
    
    
    
    /*
     let context = PersistenceController.shared.container.viewContext
    func fetchData() -> Array<Drug> {
        // fetch all Drugs an return Drug Array
        let fetchRequest: NSFetchRequest<Drug> = Drug.fetchRequest()
        var data:[Drug] = []
        do {
            let result = try context.fetch(fetchRequest)
            
            data = result
        } catch let error as NSError {
            print("ERROR FETCHING: \(error)")
        }
        return data
    }
     */
}

@main
struct PainControlWidget: Widget {
    let kind: String = "PainControlWidget"
    
    //let persistenceController = PersistenceController.shared
        
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PainControlWidgetEntryView(entry: entry)
               // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("My Widget")
        .description("Schnell eintragungen für Medikamenten einnahme")
    }
}

struct PainControlWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PainControlWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            PainControlWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            PainControlWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

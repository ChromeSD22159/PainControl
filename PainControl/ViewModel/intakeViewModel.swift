//
//  ViewModel.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import Foundation
import SwiftUI
import CoreData

// INIT IN VIEW : @StateObject var dataManager = ViewModel()

class inTakeViewModel: ObservableObject {

    
    @Published var drugName = "ibu"
    @Published var date = Date()
    @Published var pain = 0
    // Sheets
    @Published var isIntakteSheet = false
    @Published var painChatsData:[Int] = []
    
    init(){
        let context = PersistenceController.shared.container.viewContext
        
        var comps3 = DateComponents()
        comps3.day = 18
        comps3.month = 01
        comps3.year = 2022
        comps3.hour = 17
        
        let Intake3 = InTake(context: context)
        Intake3.drugName = "Ibuprofen"
        Intake3.pain = Int16(7)
        Intake3.timestamp = Calendar.current.date(from: comps3)!
        
        
        var comps2 = DateComponents()
        comps2.day = 19
        comps2.month = 01
        comps2.year = 2022
        comps2.hour = 15
        
        let Intake2 = InTake(context: context)
        Intake2.drugName = "Ibuprofen"
        Intake2.pain = Int16(8)
        Intake2.timestamp = Calendar.current.date(from: comps2)!
        
        var comps1 = DateComponents()
        comps1.day = 20
        comps1.month = 01
        comps1.year = 2022
        comps1.hour = 11
        
        let Intake1 = InTake(context: context)
        Intake1.drugName = "Ibuprofen"
        Intake1.pain = Int16(3)
        Intake1.timestamp = Calendar.current.date(from: comps1)!
        
        var comps = DateComponents()
        comps.day = 21
        comps.month = 01
        comps.year = 2022
        comps.hour = 08
        
        let inTake = InTake(context: context)
        inTake.drugName = "Ibuprofen"
        inTake.pain = Int16(2)
        inTake.timestamp = Calendar.current.date(from: comps)!
        
        extraxtData()
    }
    
    func fetchData() -> Array<InTake> {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<InTake> = InTake.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \InTake.timestamp, ascending: true)]
        var data:[InTake] = []
        do {
           let result = try context.fetch(fetchRequest)
            //print("fetching \(result.count)")
            
            data = result
        } catch let error as NSError {
            print("ERROR FETCHING: \(error)")
        }
        return data
    }
    
    func extraxtData(){
        let intakes = fetchData()
        var painData:[Int] = [0]
        
        for intake in intakes {
           // print(intake.pain)
            painData.append(Int(intake.pain))
        }
        painChatsData = painData
    }
    
    let calendar = Calendar.current
    
    func dateToHour(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }

    func checkDate() -> String {
        let getHour = dateToHour(date: date, format: "HH")

        if getHour == "08" {
            return "morgens"
        } else if getHour == "12" {
            return "mittags"
        } else if getHour == "16" {
            return "abends"
        } else if getHour == "22" {
            return "nachts"
        } else {
            return "anderes Uhrzeit"
        }
    }
    
    func updateDate(value: String) {
        if value == "morgens" {
            date = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
        } else if value == "mittags" {
            date = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        } else if value == "abends" {
            date = calendar.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
        } else if value == "nachts" {
            date = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
        }else {
                // do something
        }
    }
    
    func updateDrug(value: String){
        drugName = String(value)
    }
    
}

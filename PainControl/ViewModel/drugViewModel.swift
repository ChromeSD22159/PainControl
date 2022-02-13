//
//  DrugViewModel.swift
//  PainControl
//
//  Created by Frederik Kohler on 02.02.22.
//

import Foundation
import CoreData
import SwiftUI

class drugViewModel: ObservableObject {
    
    
    @Published var AllDrugs:[Drug] = []
    @Published var updateDrug : Drug!
    // Datet
    @Published var name:String = ""
    @Published var dose:String = ""
    @Published var morning:Bool = true
    @Published var noon:Bool = false
    @Published var evening:Bool = false
    @Published var night:Bool = false
    @Published var created = Date()
    @Published var edit = Date()
    @Published var date = Date()
    // Sheet
    @Published var isdrugSheet = false
    @Published var isEditDrugSheet = false
    
    let context = PersistenceController.shared.container.viewContext
    
    let debug = true
    
    init(){
        // init test Data when no Drugs in CoreData
       //initTestData()
    }

    
    func checkState(value: String) -> Bool {
        return true
    }
    
    func updateState(value: String) {
        if value == "morgens" {
            morning.toggle()
        } else if value == "mittags" {
            noon.toggle()
        } else if value == "abends" {
            evening.toggle()
        } else if value == "nachts" {
            night.toggle()
        }else {
                // do something
        }
    }

  
    func initTestData() {
        // Init Test Data when no Drugs in CoreData
        let fetched = fetchData()
        var medis = [
             ["Ibuprofen", "60mg"],
             ["Novalgin", "40 tropfen"],
             ["Tilidin", "100"],
             ["Ass", "100"]
         ]
    
        if fetched.count != 0 {
            medis = [[String]]()
        }
        
        for medikament in medis {
            let drug = Drug(context: context)
                drug.name = medikament[0]
                drug.dose = medikament[1]
                drug.morning = true
                drug.noon = true
                drug.evening = true
                drug.night = true
                drug.created = Date()
                drug.edit = Date()
        }
    }
    
    
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

    
    func deleteItems(at offsets: IndexSet) {
        // Delete Drug from CoreData
        AllDrugs.remove(atOffsets: offsets)
    }

    
    func editDrug(item: Drug){
        // Sync Obj State from Fetched Item
        updateDrug = item
        name = item.name!
        dose = item.dose!
        morning = item.morning
        noon = item.noon
        evening = item.evening
        night = item.noon
        created = item.created!
        edit = item.edit!
        
        // Open EditSheet
        isEditDrugSheet.toggle()
    }
    
    func updateDrugItem(){
        // when update State is Set
        if updateDrug != nil {
            updateDrug.name = name
            updateDrug.dose = dose
            updateDrug.morning = morning
            updateDrug.noon = noon
            updateDrug.evening = evening
            updateDrug.night = night
            updateDrug.created = created
            updateDrug.edit = Date()
            
            try! context.save()
            
            // removing
            updateDrug = nil
            
            isEditDrugSheet.toggle()
            
            // remove Obj State
            name = ""
            dose = ""
            morning = false
            noon = false
            evening = false
            night = false
            created = Date()
            edit = Date()
        }
    }
    
    func addDrug(){
        // Add State Drug into CoreData
        let drug = Drug(context: context)
            drug.name = "test"
            drug.dose = "dose"
            drug.morning = true
            drug.noon = false
            drug.evening = true
            drug.night = true
            drug.created = Date()
            drug.edit = Date()
    }

}




//
//  notificationManager.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import Foundation
import UserNotifications
import CoreData
import SwiftUI
import WidgetKit

// https://blckbirds.com/post/local-notifications-swiftui/

class LocalNotificationManager: ObservableObject {
    
    @Published var access:Bool = true
    
    var notifications = [Notification]()
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success == true && error == nil {
                print("Notifications access allowed")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Ask for Permisson
    func checkAccess(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func getAuthState() -> Bool {
        var state = false
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized)
            {
                state = true
            }
            else
            {
                state = false
            }
        }
        
        return state
    }
    
   
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Double) {
        // new Notification
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
           content.subtitle = subtitle
        }
        content.body = " Notification triggered"
        content.sound = UNNotificationSound.default

        // show this notification XX seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        // add our notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        // UNUserNotificationCenter.current().add(request)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    // sendNotificationOnTime(times: [8,12,16,22])
    func sendNotificationOnTime(content: [UNNotificationContent], dateComponents: [DateComponents], dev: Bool){
        // Acctuel Time
        let date = Date()
        
        _ = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        if dev {
            print("dates")
            print(dateComponents)
            for dateComponent in dateComponents {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    
                    for item in content {
                        // TestTrigger after 15s
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
                        
                        // Create the request
                        let uuidString = UUID().uuidString
                        let request = UNNotificationRequest(identifier: uuidString, content: item, trigger: trigger)
                        
                        // Schedule the request with the system.
                        let notificationCenter = UNUserNotificationCenter.current()
                        notificationCenter.add(request) { (error) in
                           if error != nil {
                              // Handle any errors.
                           }
                        }
                    }
                }
            }
            
        } else {
           /*
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
               if error != nil {
                  // Handle any errors.
               }
            }
            */
        }
        
    }

    
    func setNotificationTimes(_ hour: Int) -> DateComponents {
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = hour    // 14:00 hours
        return dateComponents
    }
    
    // CoreData Context
    let context = PersistenceController.shared.container.viewContext

    
    // fetch Drugs by times where is true
    func fetchDrugs(time: Int) -> [Drug] {
        let fetchRequest: NSFetchRequest<Drug> = Drug.fetchRequest()

        if time == 8 { fetchRequest.predicate = NSPredicate(format: "morning == YES") }
        if time == 12 { fetchRequest.predicate = NSPredicate(format: "noon == YES") }
        if time == 18 { fetchRequest.predicate = NSPredicate(format: "evening == YES") }
        if time == 22 { fetchRequest.predicate = NSPredicate(format: "night == YES") }
 
        
        //fetchRequest.predicate = NSPredicate(format: times)
        var data:[Drug] = []
        do {
            let result = try context.fetch(fetchRequest)

            data = result
        } catch let error as NSError {
            print("NotificationManager_ERROR FETCHING Drug: \(error)")
        }
        return data
    }

    func setNotifications(times: [Int], dev: Bool) {
        
        var NotificationContentList: [UNMutableNotificationContent] = []
        var NotificationDateComponents: [DateComponents] = []
        
        for time in times {
            let drugs = fetchDrugs(time: time)

            var drugList: [String] = []
            for drug in drugs {
                let name = String(drug.name!)
                drugList.append(name)
            }
            let list = drugList.joined(separator: ", ")
            
             
             let content = UNMutableNotificationContent()
             content.title = "Erinnerung zur Einnahmge"
             content.subtitle = ""
             content.body = """
                 Es ist \(time)Uhr. \
                 Zeit um \(list) einzinehmen.
                 """
             content.sound = UNNotificationSound.default
            
            // Create NotitficationArray
            NotificationContentList.append(content)
            // create Time Arrays
            NotificationDateComponents.append(setNotificationTimes(time))
        }
        
        sendNotificationOnTime(content: NotificationContentList, dateComponents: NotificationDateComponents, dev: dev)
        
    }
    
    
}

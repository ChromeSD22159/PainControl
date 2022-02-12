//
//  notificationManager.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import Foundation
import UserNotifications

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


        
        /*
         let imageName = "Apple-Logo"
         guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "jpeg") else { print("attachment fail"); return}
         
         let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
         content.attachments = [attachment]
         */
        
        
        
        // show this notification XX seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        // add our notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        // UNUserNotificationCenter.current().add(request)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}

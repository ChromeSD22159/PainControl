//
//  NavLinkNotifications.swift
//  PainControl
//
//  Created by Frederik Kohler on 10.02.22.
//

import SwiftUI
import UserNotifications

struct NavLinkNotifications: View {
 
    /*
     @EnvironmentObject var inTakeManager: inTakeViewModel
     @EnvironmentObject var viewManager: viewModels
     @EnvironmentObject var notificationManager: LocalNotificationManager
     @EnvironmentObject var tabBarManager: TabbarModel
     @EnvironmentObject var drugManager: drugViewModel
     @EnvironmentObject var AppManager: AppManagerModel

     @ObservedObject var inTakeManager: inTakeViewModel
     @ObservedObject var viewManager: viewModels
     @ObservedObject var notificationManager: LocalNotificationManager
     @ObservedObject var tabBarManager: TabbarModel
     @ObservedObject var drugManager: drugViewModel
     @ObservedObject var AppManager: AppManagerModel
     */
    @EnvironmentObject var notificationManager: LocalNotificationManager
    @State var showFootnote = false
    @AppStorage("notification") private var notification: Bool = true
    @State private var timeRemaining = 0
    @Namespace private var namespace
    
  
    var body: some View {
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        SettingLinkContainer(){
            NavigationLink(destination: {
                Section(
                    header: HStack{
                        Text("Benachrichtigungen").font(.footnote)
                        Spacer()
                    }.padding(.horizontal),
                    footer: HStack{
                        Text("Wenn sie isch dazu entschließen keine Benachriochtigungen von dieser App mehr zubekommen. Wenn die Benachrichtigungen ausgeschaltet sind, werden alle Benachrichtigungen deaktiviert und können hier in der App oder in den einstellungen Ihres iPhone's Aktiviert werden..")
                            .font(.footnote)
                            
                        Spacer()
                    }.padding(.horizontal),
                    content: {
                        VStack(spacing: 20){
                            Toggle(isOn: $notification){
                                HStack{
                                    Image(systemName: notification ? "checkmark.circle" : "x.circle")
                                    Text("Benachrichtigungen")
                                }
                            }
                            
                            
                            
                            if notification {
                                Text("Test Notification 🚀")
                                    .onTapGesture {
                                        withAnimation {
                                            showFootnote = true
                                                //9. Use the send notification function
                                                notificationManager.sendNotification(
                                                title: "Hallo Frederik",
                                                subtitle: "Wilkommen wilkommen in der PainControl App!",
                                                body: "Das ist eine Test Benachrichtigung",
                                                launchIn: 5
                                            )
                                            timeRemaining = 5
                                        }
                                        withAnimation(.easeOut){
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                                                showFootnote = false
                                            }
                                        }
                                        
                                    }
      
                                
                                if showFootnote {
                                    Text("Notification wird in \(timeRemaining) sekunden gesendet! (nicht wenn die App aktive ist!)")
                                        .font(.footnote)
                                        .matchedGeometryEffect(id: "Timer", in: namespace)
                                }
                            }
                        
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .matchedGeometryEffect(id: "Card", in: namespace)
                    }
                ).padding(.horizontal).foregroundStyle(.secondary)
            },
            //tag: Text("Erweitete Tag"),
            //selection: $currentSelection,
            label: {
                HStack(spacing: 10){
                    HStack{
                        Image(systemName: notification ? "checkmark.circle" : "x.circle")
                        Text("Benachrichtigungen")
                        
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            })
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

}

struct NavLinkNotifications_Previews: PreviewProvider {
    static var previews: some View {
        NavLinkNotifications()
    }
}

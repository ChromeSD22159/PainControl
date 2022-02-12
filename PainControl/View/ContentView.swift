//
//  ContentView.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        
        ZStack {
                        
            /*
               - - -> BACKGROUND
            */
            LinearGradient(
                colors: [
                   Color("PainControlBG")
                ], startPoint: .topLeading, endPoint: .bottomTrailing
            )
            
            
            TabBarView()
                .navigationTitle("Home")
        }
        .ignoresSafeArea()
        
    }
}


struct TabBarView : View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var inTakeManager: inTakeViewModel
    @EnvironmentObject var viewManager: viewModels
    @EnvironmentObject var notificationManager: LocalNotificationManager
    @EnvironmentObject var tabBarManager: TabbarModel
    @EnvironmentObject var drugManager: drugViewModel
    @EnvironmentObject var AppManager: AppManagerModel
  
    var body: some View {

        ZStack(alignment: .bottom) {
            
            // MARK: CONTENT PAGES
            Group{

                switch tabBarManager.selectedTab {
                case .home :
                    homeView()
                    
                case .drug :
                    drugView()
                        .sheet(isPresented:  $drugManager.isdrugSheet, content: {
                            newDrugSheet()
                        })
                        .frame(maxWidth: .infinity)
                case .plus :
                    homeView()
                        .frame(maxWidth: .infinity)
                    
                case .intake :
                    inTakeView()
                        .frame(maxWidth: .infinity)
                    
                case .settings :
                    homeView()
                        .frame(maxWidth: .infinity)// MARK: Settings Sheet
                        
                }
                   
            }
            .onAppear(perform: {
                //print("click \(tabBarManager.isSettingsSheet ? "t" : "f")")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .overlay(
            
            // MARK: Header
            Header(type: .DateTitle, title: tabBarManager.selectedTabName, titleFontSize: .title2.weight(.semibold)) {
                IconBubleBackground(systemName: "pills.fill", gradient: [.teal.opacity(0.4),.orange], degree: -45)
            }
            
            , alignment: .top
        )
        .overlay(
        
            // MARK: TABBAR
            TabBar()

            , alignment: .bottom
        )
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//
//  tabBarViewModel.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import SwiftUI

class TabbarModel: ObservableObject {
    
    @Published var selectedTab:Tab = .drug
    @Published var selectedTabName:String = "Home"
    @Published var selectedTabColor:Color = .red
    
    @Published var isSettingsSheet:Bool = false
    
    init() {
      
    }
    
    enum Tab: String {
        case home
        case drug
        case plus
        case intake
        case settings
    }

    var TabBarItems = [
        TabItem(name: "Home", icon: "house", tab: .home, color: Color.red),
        TabItem(name: "Medikament", icon: "house", tab: .drug, color: Color.teal),
        TabItem(name: "plus", icon: "plus", tab: .plus, color: Color.teal),
        TabItem(name: "Einnahme", icon: "house", tab: .intake, color: Color.orange),
        TabItem(name: "Settings", icon: "gear", tab: .settings, color: Color.green)
    ]

    struct TabItem: Identifiable {
        var id = UUID()
        var name: String
        var icon: String
        var tab: Tab
        var color: Color
    }
}

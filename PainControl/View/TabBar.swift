//
//  TabBarAnimatedColorSpacer.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import SwiftUI

// MARK: TABBAR
struct TabBar: View {
    
    @EnvironmentObject var tabBarManager : TabbarModel
    @EnvironmentObject var inTakeManager : inTakeViewModel
    
    var body: some View {
        HStack{
            ForEach(tabBarManager.TabBarItems) { item in
                
                Button {
                    withAnimation( .spring(response: 0.3, dampingFraction: 1.1) ) {
                        if item.tab == .settings {
                            tabBarManager.isSettingsSheet = true
                        } else if item.tab == .plus {
                            inTakeManager.isIntakteSheet = true
                        } else {
                            tabBarManager.selectedTab = item.tab
                            tabBarManager.selectedTabName = item.name
                            tabBarManager.selectedTabColor = item.color
                        }
                        
                    }
                } label: {
                    ZStack{
                        
                        if item.tab == .plus {
                            HexagonComponent()
                                 .frame(width: 40, height: 40)
                            
                            VStack(spacing: 0) {
                                
                                Image(systemName: item.icon)
                                    .symbolVariant(.fill)
                                    .font(.body.bold())
                                    .frame(width: 44, height: 29)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                        } else {
                            VStack(spacing: 0) {
                                
                                Image(systemName: item.icon)
                                    .symbolVariant(.fill)
                                    .font(.body.bold())
                                    .frame(width: 44, height: 29)
                               
                                Text(item.name)
                                    .font(.caption2)
                                    .lineLimit(1)
                                
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                    }
                } // label
                .foregroundStyle(tabBarManager.selectedTab == item.tab ? .primary : .secondary)
                .offset(y: item.tab == .plus ? -30 : 0)
                
            }
        } // HStack
        .padding(.horizontal, 8)
        .padding(.top, 14)
        .frame(height: 88, alignment: .top)
        .background(
            // TABBAR BACKGROUND
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 15, style: .continuous)
        )
        .background(
            // TabBar Tab BG with Animated
            TabBarAnimatedTabBG(tabBarManager: tabBarManager)
        )
        .overlay(
            
            // TabBar Color Rectangle with Animation
            TabBarAnimatedColorRectangle(tabBarManager: tabBarManager)
            
        )
        .sheet(isPresented: $inTakeManager.isIntakteSheet) {
            newIntakeSheet()
        }
        .sheet(isPresented: $tabBarManager.isSettingsSheet, content: {
            SettingsView()
        })
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(TabbarModel())
    }
}


// MARK: TABBAR Color Slider
struct TabBarAnimatedColorRectangle: View {
    @ObservedObject var tabBarManager : TabbarModel
    
    var body: some View {
        HStack{
            GeometryReader{ proxy in
                let vw = proxy.size.width
                let tabCount = tabBarManager.TabBarItems.count
                
                HStack{
                    if tabBarManager.selectedTab == .drug { Spacer() }
                    if tabBarManager.selectedTab == .plus { Spacer(); Spacer() }
                    if tabBarManager.selectedTab == .intake { Spacer(); Spacer(); Spacer() }
                    if tabBarManager.selectedTab == .settings { Spacer() }
                  
                    Rectangle()
                        .fill(tabBarManager.selectedTabColor)
                        .cornerRadius(5)
                        .frame(width: vw / CGFloat(tabCount), height: 10)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .opacity(tabBarManager.selectedTab == .plus ? 0 : 1)
                        .onChange(of: tabBarManager.selectedTab) { Tab in
                            print(Tab)
                        }
                    
                    if tabBarManager.selectedTab == .home { Spacer() }
                    if tabBarManager.selectedTab == .drug { Spacer(); Spacer(); Spacer() }
                    if tabBarManager.selectedTab == .plus { Spacer(); Spacer() }
                    if tabBarManager.selectedTab == .intake { Spacer() }
                }
                
            }
            
        }.padding(.horizontal, 8)
    }
}
struct TabBarAnimatedColorRectangle_Previews: PreviewProvider {
    static var previews: some View {
        TabBarAnimatedColorRectangle(tabBarManager: TabbarModel())
    }
}


// MARK: TABBAR Animated BackgroundColor
struct TabBarAnimatedTabBG: View {
    @ObservedObject var tabBarManager : TabbarModel
    
    var body: some View {
        HStack{
            if tabBarManager.selectedTab == .drug { Spacer() }
            if tabBarManager.selectedTab == .plus { Spacer(); Spacer() }
            if tabBarManager.selectedTab == .intake { Spacer(); Spacer(); Spacer() }
            if tabBarManager.selectedTab == .settings { Spacer() }
            
            Circle().fill(tabBarManager.selectedTabColor).frame(width:88)
           
            if tabBarManager.selectedTab == .home { Spacer() }
            if tabBarManager.selectedTab == .drug { Spacer(); Spacer(); Spacer() }
            if tabBarManager.selectedTab == .plus { Spacer(); Spacer() }
            if tabBarManager.selectedTab == .intake { Spacer() }
        }.padding(.horizontal, 8)
    }
}
struct TabBarAnimatedTabBG_Previews: PreviewProvider {
    static var previews: some View {
        TabBarAnimatedTabBG(tabBarManager: TabbarModel())
    }
}

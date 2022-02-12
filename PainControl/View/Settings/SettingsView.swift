//
//  SettingsView.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    
    @EnvironmentObject var inTakeManager: inTakeViewModel
    @EnvironmentObject var viewManager: viewModels
    @EnvironmentObject var notificationManager: LocalNotificationManager
    @EnvironmentObject var tabBarManager: TabbarModel
    @EnvironmentObject var drugManager: drugViewModel
    @EnvironmentObject var AppManager: AppManagerModel
   
    var body: some View {
        NavigationView{
            ZStack {

                Color("PainControlBG").ignoresSafeArea()
                
                ScrollView {
                    VStack{
                        
                        // PRO APP
                        SettingLinkContainer(){
                            VStack(alignment: .leading, spacing: 2){
                                Text("Alle Funktionen freischalten")
                                    .font(.footnote.weight(.semibold))
                                    
                                Text("Test")
                                    .font(.body.weight(.bold))
                                    
                            }
                            
                                            
                            Spacer()
                            
                            VStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow.opacity(0.5))
                            }
                        }
                        // Notifocation Access
                        NavLinkNotifications()
                        
                        
                        
                        SettingLinkContainer(){
                            NavigationLink(
                                destination: Text("Erweitete Detail Headline"),
                                //tag: Text("Erweitete Tag"),
                                //selection: $currentSelection,
                                label: {
                                    HStack{
                                        VStack(alignment: .leading, spacing: 2){
                                            Text("Alle Funktionen freischalten")
                                                .font(.footnote.weight(.semibold))
                                            Text(AppManager.AppName)
                                                .font(.body.weight(.bold))
                                        }
                                        
                                        
                                        Spacer()
                                        
                                        VStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow.opacity(0.5))
                                        }
                                    }
                                }
                            )
                        }
                        
                        SettingLinkContainer(){
                            VStack(spacing: 10){
                                NavigationLink(
                                    destination: Text("1 Erweitete Detail Headline"),
                                    //tag: Text("Erweitete Tag"),
                                    //selection: $currentSelection,
                                    label: {
                                        HStack(spacing: 10){
                                            Image(systemName: "cloud.fill")
                                            Text("Erweitete Funktionen")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                )
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("PainControlDivider"))
                                
                                NavigationLink(
                                    destination: Text("1 Erweitete Detail Headline"),
                                    //tag: Text("Erweitete Tag"),
                                    //selection: $currentSelection,
                                    label: {
                                        HStack(spacing: 10){
                                            Image(systemName: "cloud.fill")
                                            Text("Benachrichtigungen")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                )
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("PainControlDivider"))
                                
                                NavigationLink(
                                    destination: Text("1 Erweitete Detail Headline"),
                                    //tag: Text("Erweitete Tag"),
                                    //selection: $currentSelection,
                                    label: {
                                        HStack(spacing: 10){
                                            Image(systemName: "cloud.fill")
                                            Text("Benachrichtigungen")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                )
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("PainControlDivider"))
                                
                                NavigationLink(
                                    destination: Text("1 Erweitete Detail Headline"),
                                    //tag: Text("Erweitete Tag"),
                                    //selection: $currentSelection,
                                    label: {
                                        HStack(spacing: 10){
                                            Image(systemName: "cloud.fill")
                                            Text("Benachrichtigungen")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                )
                            }
                        }
                        
                        SettingLinkContainer(){
                            NavigationLink(
                                destination: {
                                    Section(
                                        header: HStack{
                                            Text("Headline").font(.footnote)
                                            Spacer()
                                        }.padding(.horizontal),
                                        footer: HStack{
                                            Text("Structured speichert automatisch Backups").font(.footnote)
                                            Spacer()
                                        }.padding(.horizontal),
                                        content: {
                                            HStack{
                                                Image(systemName: "house")
                                                    .foregroundColor(.secondary.opacity(0.6))
                                                Text("Erweitete Detail Headline")
                                                Spacer()
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(.secondary)
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(10)
                                        }
                                    ).padding(.horizontal)
                                },
                                //tag: Text("Erweitete Tag"),
                                //selection: $currentSelection,
                                label: {
                                    HStack(spacing: 10){
                                        Image(systemName: "cloud.fill")
                                        Text("Erweitete")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            )
                        }
 
                        Spacer()
                    } // Vstack
                    .foregroundColor(.secondary)
                    .padding()
                    
                    .navigationBarItems(trailing: Button("Schließen"){ tabBarManager.isSettingsSheet.toggle() })
                    .navigationTitle("Einstellungen")
                    
                }
                
            }
        }
    }
}

/*
struct SettingsView_dark_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .environmentObject(LocalNotificationManager())
                .environmentObject(TabbarModel())
                .environmentObject(AppManagerModel())
                
        }
    }
}

struct SettingsView_P: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .environmentObject(LocalNotificationManager())
                .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
*/

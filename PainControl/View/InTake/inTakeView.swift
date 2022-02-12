//
//  drugView.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import SwiftUI
import UIKit // for time Formatter

// MARK: VIEW
struct inTakeView: View {
    @Environment(\.managedObjectContext) private var viewContext

     @EnvironmentObject var inTakeManager: inTakeViewModel
     @EnvironmentObject var notificationManager: LocalNotificationManager
     @EnvironmentObject var tabBarManager: TabbarModel
     @EnvironmentObject var drugManager: drugViewModel
     @EnvironmentObject var AppManager: AppManagerModel

        
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \InTake.timestamp, ascending: false)],
        animation: .default)
    private var allinTakes : FetchedResults<InTake>
    
    @State private var introText = false
    @Namespace var namespace
    var body: some View {
        let LinearGradient:[Color] = [Color.pink.opacity(1),Color.orange.opacity(1)]
        
        ScrollView {
            VStack(alignment: .leading, spacing: 30.0) {
                
                Text("")
                    .padding(.top, 150)
                
                ZStack{
                    // LineGraph
                     VStack {
                         LineGraph(data: inTakeManager.painChatsData)
                     }
                     .frame(height: 300)
                     .frame(maxWidth: .infinity)
                    
                    VStack{
                        HStack{
                            Spacer()
                            inTakeIntroText(LinearGradient: LinearGradient, namespace: namespace, introText: $introText)
                        }
                        Spacer()
                    }
                    .frame(height: 300)
                }
                
                
                
                
                
                
                // Button Section
                HStack{
                    Button(action: {
                        inTakeManager.isIntakteSheet.toggle()
                        
                    }, label: {
                        Text("Schmerzmittel einnahme")
                    })
                        .sheet(isPresented: $inTakeManager.isIntakteSheet, content: {
                            newIntakeSheet()
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20.0)
                    .foregroundColor(.white)
                    .lineaGradientBackground(colors: LinearGradient, startPoint: .leading, endPoint: .trailing)
                    .cornerRadius(20)
                    
                    Button(action: {
                        inTakeManager.extraxtData()
                    }, label: {
                        Text("Test")
                    })
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20.0)
                    .foregroundColor(.white)
                    .lineaGradientBackground(colors: LinearGradient, startPoint: .leading, endPoint: .trailing)
                    .cornerRadius(20)
                }
                
                // Head Section
                HStack {
                    HStack{
                        Text("Schmerzen")
                            .font(.footnote.weight(.bold))
                        
                        Spacer()
                        
                        Text("Schmerzenmittel")
                            .font(.footnote.weight(.semibold))
                    }
                }
                
                
                // loop CoreData Section
                VStack(alignment: .trailing, spacing: 10.0) {
                    if allinTakes.count > 0 {
                        ForEach(allinTakes, id: \.self) { inTake in
                            HStack {
                               
                                Text("\(inTake.pain)")
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 3.0) {
                                    Text("\(inTake.drugName!)")
                                    HStack{
                                        Text(inTake.timestamp!, style: .date)
                                            .font(.footnote)
                                        Text(inTake.timestamp!, style: .time)
                                            .font(.footnote)
                                    }
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                           
                            
                        }
                    } else {
                        HStack {
                            Text("Keine Daten vorhanden")
                        }
                        
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Text("")
                    .frame(height: 50)
                
                Spacer()
                
                .navigationTitle("Einnahme")
                
            }
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.width)
            .padding(.horizontal)
            .foregroundColor(.secondary)
        }

    }
}


// MARK: INTAKE INTROTEXT
struct inTakeIntroText: View{
    let LinearGradient:[Color]
    let namespace: Namespace.ID
    @Binding var introText: Bool
    
    var body: some View {
        ZStack{
            if !introText {
                VStack{
                    HStack {
                        Image(systemName: "questionmark")
                            .matchedGeometryEffect(id: "buttonMark", in: namespace)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)){
                                    introText.toggle()
                                }
                            }
                    }
                    .matchedGeometryEffect(id: "sizeing", in: namespace)
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20.0)
                .lineaGradientBackground(
                    colors: LinearGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .cornerRadius(20)
                .offset(y: -50)
                
            } else {
                VStack{
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .matchedGeometryEffect(id: "buttonMark", in: namespace)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)){
                                    introText.toggle()
                                }
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 0.0) {
                        Text("Schmerzmittel hinzufügen")
                            .matchedGeometryEffect(id: "header", in: namespace)
                            .font(.title2.weight(.semibold))
                            
                        Text("Dieses Tagebuch soll für 14 Tage Ihr Begleiter sein. Mithilfe der täglichen Eintragung Ihres persönlichen Schmerzempfindens kann Ihr Arzt die für Sie passende Therapie verordnen bzw. die Wirksamkeit der Behandlung überprüfen.")
                            .matchedGeometryEffect(id: "text", in: namespace)
                            .padding(.top, 5)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .cornerRadius(20)
                    
                }
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20.0)
                .lineaGradientBackground(
                    colors: LinearGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                .cornerRadius(20)
                .offset(y: -50)
               
            }
        }
    }
}


// MARK: PREVIEW
struct inTakeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                
            ContentView()
            .preferredColorScheme(.light)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}




// MARK: BUTTON
extension View {
  func medibutton() -> some View {
    modifier(Medibutton())
  }
}

struct Medibutton: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.vertical, 10)
      .padding(.horizontal, 20.0)
      .foregroundColor(.white)
      .lineaGradientBackground(colors: [Color.teal.opacity(1),Color.teal.opacity(1)], startPoint: .top, endPoint: .bottom)
      .cornerRadius(20)
  }
}

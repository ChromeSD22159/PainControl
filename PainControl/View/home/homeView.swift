//
//  HomeView.swift
//  PainControl
//
//  Created by Frederik Kohler on 04.02.22.
//

import SwiftUI

struct homeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Drug.objectID, ascending: true)],
        animation: .default)
    private var DrugItems: FetchedResults<Drug>
    
    @Namespace var namespace01
    @Namespace var namespace02
    
    @State var show = false
    @State var contentText = false
    
    @State private var selectedDrug = ""
    @State private var selectedPain = 1
    
    var body: some View {
        VStack {

            ScrollView{
                CardView()
                
                VStack(spacing: 5){
                    HStack{
                        Spacer()
                        Picker("", selection: $selectedDrug) {
                            if selectedDrug == "" {
                                Text("Medikament wählen")
                            } else {
                                Text("\(selectedDrug)")
                            }
                            
                            
                            ForEach(DrugItems, id: \.self) { drug in
                                Text(drug.name!)
                            }
                        }
                        Spacer()
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            colors: [
                                .teal.opacity(0.3),
                                .teal.opacity(0.4),
                                .teal.opacity(0.5),
                                .teal.opacity(0.5),
                                .teal.opacity(0.5),
                                .teal.opacity(0.4),
                                .teal.opacity(0.3),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                    
                    HStack{
                        Spacer()
                        Picker("", selection: $selectedPain) {
                            
                            Text("\(selectedPain)")
                            
                            ForEach(1..<11) { pain in
                                Text("\(pain)")
                            }
                        }
                        Spacer()
                    }
                    .padding(8)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            colors: [
                                .teal.opacity(0.3),
                                .teal.opacity(0.4),
                                .teal.opacity(0.5),
                                .teal.opacity(0.5),
                                .teal.opacity(0.5),
                                .teal.opacity(0.4),
                                .teal.opacity(0.3),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(20)
                }
                .padding()
                
                
                Button("Schnelleintragung") {
                    
                }
                .padding(8)
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        colors: [
                            .teal.opacity(0.3),
                            .teal.opacity(0.4),
                            .teal.opacity(0.5),
                            .teal.opacity(0.5),
                            .teal.opacity(0.5),
                            .teal.opacity(0.4),
                            .teal.opacity(0.3),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                
                
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 150)
            }

        }
        .frame(maxWidth: .infinity)
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




/*
 HStack{
     Button(action: {
         inTakeManager.isIntakteSheet.toggle()
     }, label: {
         Text("New Intake")
     })
     .sheet(isPresented: $inTakeManager.isIntakteSheet, content: {
         newIntakeSheet(drugManager: drugManager, inTakeManager: inTakeManager)
     })
     .padding(.vertical, 10)
     .padding(.horizontal, 20.0)
     .foregroundColor(.white)
     .lineaGradientBackground(colors: [.teal,.blue], startPoint: .topTrailing, endPoint: .bottomLeading)
     .cornerRadius(20)

     Button(action: {
         drugManager.isdrugSheet.toggle()
     }, label: {
         Text("New Drug")
     })
     .sheet(isPresented:  $drugManager.isdrugSheet, content: {
         newDrugSheet(drugManager: drugManager)
     })
     .padding(.vertical, 10)
     .padding(.horizontal, 20.0)
     .foregroundColor(.white)
     .lineaGradientBackground(colors: [.teal,.blue], startPoint: .topTrailing, endPoint: .bottomLeading)
     .cornerRadius(20)
 }
 */

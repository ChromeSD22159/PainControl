//
//  newSheet.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import SwiftUI

struct newDrugSheet: View {
    
    @EnvironmentObject var drugManager : drugViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Drug.created, ascending: false)],
        animation: .default)
    private var Drugs: FetchedResults<Drug>

    var body: some View {
        
        ZStack {
            
            Color("PainControlBG").ignoresSafeArea()
            
            VStack {
                
                // Header
                ZStack {
                 
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Button(action: {
                            drugManager.isdrugSheet.toggle()
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.title)
                        })
                    }
                    .padding()
                    
                }
                .frame(height: 80)
                .foregroundColor(Color("PainControlCardText"))
                .background(
                    Color("PainControlCardBG")
                )
                .cornerRadius(20, corners: [.topLeft, .bottomRight])
                
                // Content
                VStack{
                    
                    // header
                    HStack{
                        Text("Schmerzmittel hinzufügen")
                            .foregroundColor(Color("PainControlCardText"))
                            .font(.title2)
                    }
                    
                    // Fields
                    HStack(alignment: .top, spacing: 30){
                        
                        VStack(alignment: .leading, spacing: 30) {
                            Text("Medikament")
                               .font(.headline)
                            
                            Text("Einheit")
                               .font(.headline)
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            TextField("z.B. Ibuprofen", text: $drugManager.name)
                            TextField("z.B. 600mg", text: $drugManager.dose)
                        }
                        
                    }
                    .padding()

                    
                    // buttons
                    HStack{
                        DrugButton(title: "morgens")
                        DrugButton(title: "mittags")
                        DrugButton(title: "abends")
                        DrugButton(title: "nachts")
                    }
         
                }
                .padding()
                .foregroundColor(Color("PainControlCardText"))
                .background(
                    Color("PainControlCardBG")
                )
                .cornerRadius(10)
                .padding()
                
                // Send Object
                HStack(){
                    
                    Button(action: {
     
                        let drug = Drug(context: viewContext)
                        drug.name = drugManager.name
                        drug.dose = drugManager.dose
                        drug.morning = drugManager.morning
                        drug.noon = drugManager.noon
                        drug.evening = drugManager.evening
                        drug.night = drugManager.night
                        drug.created = drugManager.date
                        drug.edit = drugManager.date
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            drugManager.isdrugSheet.toggle()
                        }
                       
                    }, label: {
                        
                        Label(title: {
                            Text("Schmerzmittel hinzufügen")
                                .font(.headline)
                                .foregroundColor(drugManager.name.count <= 3 &&  drugManager.dose.count <= 3 ? Color("PainControlCardText").opacity(0.5) : Color("PainControlCardText").opacity(1))
                        }, icon: {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(drugManager.name.count <= 3 &&  drugManager.dose.count <= 3 ? Color("PainControlCardText").opacity(0.5) : Color("PainControlCardText").opacity(1))
                        })
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .lineaGradientBackground(colors: [Color("PainControlCardBG")], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(20)
                        
                    })
                    .disabled(
                        drugManager.name.count <= 3 &&  drugManager.dose.count <= 3
                    )
                    .padding()
                    
                    
                    
                }
                
                Spacer()
             
                
                
            }
            .background(Color.black.opacity(0.02))
            
        }
        
    }
    
    // MARK: ADD DRUG
    private func addItem() {
        withAnimation {
            let drug = Drug(context: viewContext)
            drug.name = drugManager.name
            drug.dose = drugManager.dose
            drug.morning = drugManager.morning
            drug.noon = drugManager.noon
            drug.evening = drugManager.evening
            drug.night = drugManager.night
            drug.created = drugManager.date
            drug.edit = drugManager.date

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

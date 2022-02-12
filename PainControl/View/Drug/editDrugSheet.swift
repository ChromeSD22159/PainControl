//
//  newSheet.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import SwiftUI

struct editDrugSheet: View {

    @EnvironmentObject var drugManager: drugViewModel
    
    var body: some View {
        ZStack {
            
            Color("PainControlBG").ignoresSafeArea()
            
            VStack {
                
                // Header
                ZStack {
                 
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        Button(action: {
                            drugManager.isEditDrugSheet.toggle()
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.title)
                        })
                    }
                    .padding()
                    
                }
                .frame(height: 80)
                .foregroundColor(.black)
                .background(
                    .gray.opacity(0.1)
                )
                .cornerRadius(20, corners: [.topLeft, .bottomRight])
                
                // Content
                VStack{
                    
                    // header
                    HStack{
                        Text("Schmerzmittel bearbeiten")
                            .foregroundColor(.secondary)
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
                            HStack{
                                TextField("z.B. Ibuprofen", text: $drugManager.name)
                            }
                            HStack{
                                TextField("z.B. 600mg", text: $drugManager.dose)
                            }
                            
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
                .foregroundColor(.secondary)
                
                
                // Send Object
                HStack(){
                    
                    Button(action: {
     
                        drugManager.updateDrugItem()

                    }, label: {
                        
                        Label(title: {
                            Text("Schmerzmittel ändern")
                                .font(.headline)
                                .foregroundColor(drugManager.name.count <= 3 &&  drugManager.dose.count <= 3 ? .white.opacity(0.5) : .white.opacity(1))
                        }, icon: {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(drugManager.name.count <= 3 &&  drugManager.dose.count <= 3 ? .white.opacity(0.5) : .white.opacity(1))
                        })
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .lineaGradientBackground(colors: [.teal,.teal], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(20)
                        
                    })
                    .padding()
                    
                    
                    
                }
                
                Spacer()
             
                
                
            }
            .background(Color.black.opacity(0.02))
            
        }
    }
    
    
}

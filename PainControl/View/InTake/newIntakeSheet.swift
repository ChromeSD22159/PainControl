//
//  newSheet.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import SwiftUI

struct newIntakeSheet: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Drug.objectID, ascending: true)],
        animation: .default)
    private var DrugItems: FetchedResults<Drug>
    
  
    @EnvironmentObject var inTakeManager: inTakeViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                
                // Header
                ZStack {
                 
                    HStack(alignment: .center, spacing: 0) {
                        Text("Schmerzmittel einnahme")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button(action: {
                            inTakeManager.isIntakteSheet.toggle()
                        }, label: {
                            Image(systemName: "x.circle")
                                .font(.title)
                        })
                    }
                    .padding()
                    
                }
                .frame(height: 80)
                .foregroundColor(.secondary)
                .background(.ultraThinMaterial)
                .cornerRadius(20, corners: [.topLeft, .bottomRight])
                
                HStack{
                   
                }
                
                
                // MARK: Drugs
              
                VStack{
                    HStack{
                        Text("Medikamente")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding([.top, .leading])
                    
                    
                    VStack{
                        let i = CGFloat(8)
                        ForEach(DrugItems, id: \.self) { drug in
                            inTakeSheetDrugButton(name: drug.name!,dose: drug.dose!, innerPadding: i)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                
                
                // MARK: Times
                VStack{
                    HStack{
                        Text("Einnahme Zeit")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding([.top, .leading])
                    
                    HStack{
                        let p = 0
                        let i = CGFloat(8)
                        DataButton(title: "morgens", innerPadding: i)
                            .dynamicFontSize(padding: p, devider: 4)
                        DataButton(title: "mittags", innerPadding: i)
                            .dynamicFontSize(padding: p, devider: 4)
                        DataButton(title: "abends", innerPadding: i)
                            .dynamicFontSize(padding: p, devider: 4)
                        DataButton(title: "nachts", innerPadding: i)
                            .dynamicFontSize(padding: p, devider: 4)
                    }
                    .padding()
                    
                    HStack {
                        DatePicker("Uhrzeit", selection: $inTakeManager.date, displayedComponents: .hourAndMinute)
                            //.labelsHidden()
                            .transformEffect(.init(scaleX: 0.9, y: 0.9))
                            .environment(\.locale, Locale.init(identifier: "pt"))
                    }
                    .padding()
                    
                }
               
                
                // MARK: PAINsaa                VStack{
                    HStack{
                        Text("Stärke der Schmerzen")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding([.top, .leading])
                    
                    HStack{
                        let width = UIScreen.main.bounds.width / 9
                        let fontSize = UIScreen.main.bounds.width / 9 / 2
                        ForEach(0..<6){ i in
                            Button(
                                action: {
                                    withAnimation(.spring()) {
                                        inTakeManager.pain = i
                                    }
                                }, label: {
                                    HStack{
                                        Text("\(i)")
                                            .font(.system(size: CGFloat(fontSize) ))
                                            .foregroundColor(inTakeManager.pain == i ? .white : .gray)
                                            .padding(7)
                                    }
                                    .frame(width: width, height: width)
                                    .background(
                                        LinearGradient(colors: inTakeManager.pain == i ? [.pink,.orange] : [.white], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(40)
                                }
                            )
                        }
                      
                    }
                    .padding()
                    
                    HStack{
                        let width = UIScreen.main.bounds.width / 9
                        let fontSize = UIScreen.main.bounds.width / 9 / 2
                        ForEach(6..<11){ i in
                            Button(
                                action: {
                                    withAnimation(.spring()) {
                                        inTakeManager.pain = i
                                    }
                                }, label: {
                                    HStack{
                                        Text("\(i)")
                                            .font(.system(size: CGFloat(fontSize) ))
                                            .foregroundColor(inTakeManager.pain == i ? .white : .gray)
                                            .padding(7)
                                    }
                                    .frame(width: width, height: width)
                                    .background(
                                        LinearGradient(colors: inTakeManager.pain == i ? [.pink,.orange] : [.white], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(40)
                                }
                            )
                        }
                      
                    }
                    .padding()
                }
                
                
                // MARK: SEND DATA
                HStack(){
                    Button(action: {
                        let inTake = InTake(context: viewContext)
                        inTake.drugName = inTakeManager.drugName
                        inTake.pain = Int16(inTakeManager.pain)
                        inTake.timestamp = inTakeManager.date
                        
                        inTakeManager.extraxtData()
                        
                        inTakeManager.isIntakteSheet.toggle()
                        // reset State
                        inTakeManager.drugName = ""
                        inTakeManager.date = Date()
                        inTakeManager.pain = 10
                    }, label: {
                        
                        Label(title: {
                            Text("Einnahme hinzufügen")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }, icon: {
                            Image(systemName: "house")
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .lineaGradientBackground(colors: [.orange,.pink], startPoint: .topTrailing, endPoint: .bottomLeading)
                        .cornerRadius(20)
                    })
                    .padding()
                }
                
                
                
                // MARK: MODELPREVIEW
                VStack(alignment: .leading, spacing: 5.0){
                    Text("ModelData")
                        .font(.largeTitle)
                    Divider()
                    Text(inTakeManager.drugName)
                    Text("\(inTakeManager.pain)")
                    Text("\(inTakeManager.date)")
                }
                .foregroundColor(.secondary)
                
                
                Spacer()
                
            }
            .background(Color.black.opacity(0.02))
        }
    }

/*
struct newSheet_Previews_s: PreviewProvider {
    static var previews: some View {
        VStack {
            newIntakeSheet(viewManager: viewModels())
                .preferredColorScheme(.dark)
                .previewDisplayName("Large")
                .previewDevice("iPhone 12")
        }
    }
}

struct newSheet_Previews_L: PreviewProvider {
    static var previews: some View {
        VStack {
            newIntakeSheet(viewManager: viewModels())
                //.preferredColorScheme(.light)
                .previewDisplayName("Large")
                .previewDevice("iPhone 12")
        }
    }
}
 */

//
//  drugView.swift
//  PainControl
//
//  Created by Frederik Kohler on 03.02.22.
//

import SwiftUI

struct drugView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
   
   
     @EnvironmentObject var tabBarManager: TabbarModel
     @EnvironmentObject var drugManager: drugViewModel

    
    var body: some View {
        let LinearGradient:[Color] = [Color.teal.opacity(1),Color.teal.opacity(1)]
        
        VStack(alignment: .leading, spacing: 30.0) {
            
            TopSpacer()
            
            // ButtonRow
            ButtonRow(LinearGradient: LinearGradient)

            
            // DrugList
            DrugList(LinearGradient: LinearGradient)
                
            
            Spacer()
            
            .navigationTitle("Medikamente")
            .toolbar {
                ToolbarItemGroup(placement: .navigation) {
                    AppLogo(name: "PainControl", iconName: "pills")
                }
            }
            .sheet(isPresented: $drugManager.isdrugSheet) {
                newDrugSheet()
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.width)
        .padding(.horizontal)
        .foregroundColor(.secondary)

    }
}

// MARK: IntroText
struct introText :View {
    var LinearGradient: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text("Schmerzmittel hinzufügen")
                .font(.title2)
                .fontWeight(.semibold)
                
            Text("Für die Erfassung der Schmerzsymptome und Ihre Beobachtungen können Sie ein Protokoll nutzen. Im Folgenden stellen wir Ihnen die möglichkeit individuelle Schmerzmedikation für Ihr persönlichen SchmerzProtokoll hinzuzufügen.")
                .padding(.top, 5)
        }
        .foregroundColor(Color("PainControlCardText"))
        .padding()
        .lineaGradientBackground(
            colors: [
                Color("PainControlCardBG").opacity(0.3),
                Color("PainControlCardBG").opacity(0.4),
                Color("PainControlCardBG").opacity(0.5),
                Color("PainControlCardBG").opacity(0.5),
                Color("PainControlCardBG").opacity(0.5),
                Color("PainControlCardBG").opacity(0.4),
                Color("PainControlCardBG").opacity(0.3),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .cornerRadius(20)
    }
}

// MARK: Button Row
struct ButtonRow: View {
    @EnvironmentObject var drugManager: drugViewModel
    var LinearGradient: [Color]
    @State private var info = false
    @Namespace private var namespace
    
    var body: some View {
        HStack{
            ZStack{
                // LineGraph
                 VStack {
                     introText(LinearGradient: [Color.teal.opacity(1),Color.teal.opacity(1)])
                         .opacity(info ? 1 : 0)
                         .matchedGeometryEffect(id: "opacity", in: namespace)
                 }
                 .frame(height: info ? 300 : 0)
                    .matchedGeometryEffect(id: "height", in: namespace)
                 .frame(maxWidth: info ? .infinity : 0)
                    .matchedGeometryEffect(id: "width", in: namespace)
                
                VStack{
                    HStack{
                        // ADD BUTTON
                        Button(action: {
                            drugManager.isdrugSheet.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Schmerzmittel")
                            }
                        })
                        .foregroundColor(Color("PainControlCardText"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20.0)
                        .lineaGradientBackground(
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
                            endPoint: .bottomTrailing)
                        .cornerRadius(20)
                        
                        Spacer()
                        
                        //Button
                        Button(action: {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                                info.toggle()
                            }
                        }, label: {
                            HStack {
                                Image(systemName: info ? "questionmark" : "xmark")
                                    .matchedGeometryEffect(id: "icon", in: namespace)
                            }
                        })
                        .foregroundColor(Color("PainControlCardText"))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20.0)
                        .lineaGradientBackground(
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
                            endPoint: .bottomTrailing)
                        .cornerRadius(20)
                        
                    }
                    Spacer()
                }
                .frame(height: info ? 300 : 0)
            }
        }
    }
}

// MARK: DrugList
struct DrugList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Drug.created, ascending: false)],
        animation: .default)
    private var Drugs: FetchedResults<Drug>
    var LinearGradient: [Color]
    
    @EnvironmentObject var drugManager: drugViewModel
    
    var body: some View{
        
        List {
            
            // TODO: REMOVE LIST BACKGROUND and insert Color("painCrontrolBG")
            
            ForEach(Drugs, id: \.self) { drug in
                
                // DrugListRow
                DrugListRow(drug: drug, LinearGradient: LinearGradient)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .listRowBackground(Color.clear)
                
            }
            
        }
        .listStyle(.plain)
        .frame(minHeight: 200)
        //.frame(height: DrugCountHeightForList(multiplie: CGFloat(Drugs.count), text: "T", font: UIFont.preferredFont(forTextStyle: .body), width: 300, padding: 10) )
        .frame(height: DrugCountHeightForList(multiplie: CGFloat(Drugs.count), text: "T", font: UIFont.preferredFont(forTextStyle: .body), width: 300, paddings: CGFloat(7 * 10)))
        .onAppear {
            // Set the default to clear
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().backgroundColor = .none
            UITableView.appearance().backgroundColor = .none
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { Drugs[$0] }.forEach(viewContext.delete)

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


// MARK: DrugListRow
struct DrugListRow: View{
    
    @EnvironmentObject var tabBarManager: TabbarModel
    @EnvironmentObject var drugManager: drugViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
 
    var drug:FetchedResults<Drug>.Element
    var LinearGradient: [Color]
    

    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack(spacing: 20) {
                HStack{
                    Image(systemName: "pills.fill")
                        .rotationEffect(.degrees(90))
                    Text(drug.name ?? "")
                }
                .onTapGesture {
                    drugManager.editDrug(item: drug)
                    print("click Edit Drug")
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    HStack(alignment: .center, spacing: 0.0){
                        Image(systemName: "sun.and.horizon")
                            .font(.system(size: 14))
                    }
                    .frame(width: 28, height: 28, alignment: .center)
                    .foregroundColor(drug.morning ? .white : .gray)
                    .lineaGradientBackground(colors: drug.morning ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .cornerRadius(10)
                    
                    HStack(alignment: .center, spacing: 0.0){
                        Image(systemName: "sun.min")
                            .font(.system(size: 14))
                    }
                    .frame(width: 28, height: 28, alignment: .center)
                    .foregroundColor(drug.noon ? .white : .gray)
                    .lineaGradientBackground(colors: drug.noon ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .cornerRadius(10)
                    
                    HStack(alignment: .center, spacing: 0.0){
                        Image(systemName: "sunset")
                            .font(.system(size: 14))
                    }
                    .frame(width: 28, height: 28, alignment: .center)
                    .foregroundColor(drug.evening ? .white : .gray)
                    .lineaGradientBackground(colors: drug.evening ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .cornerRadius(10)
                    
                    HStack(alignment: .center, spacing: 0.0){
                        Image(systemName: "moon.stars")
                            .font(.system(size: 14))
                    }
                    .frame(width: 28, height: 28, alignment: .center)
                    .foregroundColor(drug.night ? .white : .gray)
                    .lineaGradientBackground(colors: drug.night ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .cornerRadius(10)
                }
                .onTapGesture {
                    drugManager.editDrug(item: drug)
                    print("click Edit Drug")
                }
                
                HStack(alignment: .center, spacing: 0.0){
                    Image(systemName: "trash")
                        .font(.system(size: 14))
                }
                .frame(width: 28, height: 28, alignment: .center)
                .foregroundColor( .white )
                .lineaGradientBackground(colors:  [.teal.opacity(0.75)], startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(10)
                .onTapGesture {
                    viewContext.delete(drug)
                    print("click Delete Drug")
                }
                
            }
            .padding()
            .foregroundColor(.primary)
            .lineaGradientBackground(
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
                endPoint: .bottomTrailing)
            .cornerRadius(20)
            .sheet(isPresented: $drugManager.isEditDrugSheet) {
                editDrugSheet()
            }
        }
    }
}

struct ListBody: View {
    var drug:FetchedResults<Drug>.Element
    var LinearGradient: [Color]
    
    var body: some View {
        HStack {
            Text("\(drug.name!)")
            Text("\(drug.dose!)")
                .font(.footnote.weight(.semibold))
            Spacer()
        }
        
    }
}

struct ListDetail: View {
    var drug:FetchedResults<Drug>.Element
    var LinearGradient: [Color]
    @ObservedObject var viewManager : viewModels
    @State private var newName = ""
    @State private var newDose = ""
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                
                HStack{
                    Text("Medikamanet:")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    TextField("", text: $newName)
                        .font(.headline)
                }
                
                HStack{
                    Text("Dosis:")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    TextField("", text: $newDose)
                        .font(.headline)
                }
                
            }
            .foregroundColor(.primary)
            .onAppear {
                newName = drug.name!
                newDose = drug.dose!
            }
           
            
            
            // ICONS
            HStack {
                HStack(alignment: .center, spacing: 0.0){
                    Image(systemName: "sun.and.horizon")
                        .font(.system(size: 15))
                }
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(drug.morning ? .white : .gray)
                .lineaGradientBackground(colors: drug.morning ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(10)
                
                HStack(alignment: .center, spacing: 0.0){
                    Image(systemName: "sun.min")
                        .font(.system(size: 16))
                }
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(drug.noon ? .white : .gray)
                .lineaGradientBackground(colors: drug.noon ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(10)
                
                HStack(alignment: .center, spacing: 0.0){
                    Image(systemName: "sunset")
                        .font(.system(size: 15))
                }
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(drug.evening ? .white : .gray)
                .lineaGradientBackground(colors: drug.evening ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(10)
                
                HStack(alignment: .center, spacing: 0.0){
                    Image(systemName: "moon.stars")
                        .font(.system(size: 16))
                }
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(drug.night ? .white : .gray)
                .lineaGradientBackground(colors: drug.night ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                .cornerRadius(10)
                
            } // ICONS
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        
    }
}

struct drugView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


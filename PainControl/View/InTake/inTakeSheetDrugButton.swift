//
//  inTakeSheetDrugButton.swift
//  PainControl
//
//  Created by Frederik Kohler on 04.02.22.
//

import SwiftUI

struct inTakeSheetDrugButton: View {
    var name : String
    var dose : String
    var innerPadding: CGFloat = 5
    
    @EnvironmentObject var inTakeManager: inTakeViewModel
  
    var body: some View {
        
        Button(action: {
            inTakeManager.updateDrug(value: name)
        }, label: {
            
            HStack{
                Text(name)
                    .fontWeight(.semibold)
                Text(dose)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .font(.system(size: 12))
            .padding(.vertical, innerPadding)
            .padding(.horizontal, innerPadding * 2)
            .foregroundColor(inTakeManager.drugName == name ? .white : .gray)
            .lineaGradientBackground(colors: inTakeManager.drugName == name ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
            .cornerRadius(10)
            
            
        })
    }
}

struct inTakeSheetDrugButton_Previews: PreviewProvider {
    static var previews: some View {
        inTakeSheetDrugButton(name: "Medimaneten Namen", dose: "dosis")
    }
}

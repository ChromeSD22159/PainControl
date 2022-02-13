//
//  Test.swift
//  PainControl
//
//  Created by Frederik Kohler on 10.02.22.
//

import SwiftUI

struct Test: View {
    var body: some View {
        
        ZStack {
            
            
            LinearGradient(
                colors: [
                   Color("PainControlBG")
                ], startPoint: .topLeading, endPoint: .bottomTrailing
            )
            
            
            
                Button(action: {
                    //
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Schmerzmittel")
                    }
                    
                })
                
                .padding(.vertical, 10)
                .padding(.horizontal, 20.0)
                .lineaGradientBackground(
                    colors: [
                        Color("DrugRow").opacity(0.1),
                        Color("DrugRow").opacity(0.6),
                        Color("DrugRow").opacity(0.7),
                        Color("DrugRow").opacity(1),
                        Color("DrugRow").opacity(1),
                        Color("DrugRow").opacity(1),
                        Color("DrugRow").opacity(0.7),
                        Color("DrugRow").opacity(0.6),
                        Color("DrugRow").opacity(0.1),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .foregroundColor(Color("PainControlCardText"))
                .border(
                    .white.opacity(0.06),
                    width: 2,
                    cornerRadius: 20
                )
            }
        
        
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
            .preferredColorScheme(.dark)
            
    }
}

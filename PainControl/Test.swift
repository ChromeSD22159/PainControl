//
//  Test.swift
//  PainControl
//
//  Created by Frederik Kohler on 10.02.22.
//

import SwiftUI

struct Test: View {
    var body: some View {
        VStack{
            CardView()
        }
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height: 150)
        }
        .overlay(
            ZStack{
                Color.clear
                    .background(.ultraThinMaterial)
                    .blur(radius: 10)
                HStack{
                    Text("Header")
                        .font(.largeTitle.weight(.semibold))
                    Spacer()
                }
                .padding()
            }
            .frame(height: 70)
            
            , alignment: .top
        )
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

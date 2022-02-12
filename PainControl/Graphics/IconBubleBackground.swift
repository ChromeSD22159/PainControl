//
//  IconBubleBackground.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import SwiftUI

struct IconBubleBackground: View {
    
    var systemName: String
    var gradient: [Color]
    var degree: Double
    
    init(
        systemName:String = "house",
        gradient: [Color] = [ .orange, .pink, .blue, .teal ],
        degree:Double = 45
    ){
        self.systemName = systemName
        self.gradient = gradient
        self.degree = degree
    }
    
    var body: some View {
        ZStack{
            Circle()
                .fill(
                    LinearGradient(
                        colors: gradient,
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .rotationEffect(.degrees(degree))
                .shadow(color: .gray, radius: 2, x: 3 , y: 3)
                .frame(width: 35)
                .offset(x: 10, y: -5)
            
            Text("")
                .frame(width: 40, height: 40)
                .background(
                    .secondary,
                    in: RoundedRectangle(cornerRadius: 40, style: .continuous)
                )
                .offset(x: 0, y: 5)
            
            Image(systemName: systemName)
                .offset(x: 0, y: 5)
                .foregroundColor(.white)
        }
        .frame(width: 60, height: 60)

    }
}

struct IconBubleBackground_Previews: PreviewProvider {
    static var previews: some View {
        IconBubleBackground(systemName: "house", gradient: [])
    }
}

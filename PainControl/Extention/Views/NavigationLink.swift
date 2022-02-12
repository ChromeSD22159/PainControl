//
//  NavigationLink.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import SwiftUI



struct SettingLinkContainer<Content: View>: View {

    private let builder: () -> Content
    
    
    init(
        @ViewBuilder _ builder: @escaping () -> Content
    ){
        self.builder = builder
    }

    var body: some View {
        
        HStack(spacing: 0){
            HStack{
                    builder()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("PainControlCardBG"))
        .foregroundColor(Color("PainControlCardText"))
        .cornerRadius(10)
        
    }
}

struct SSettingLinkContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingLinkContainer(){
            Text("Text")
        }
            .preferredColorScheme(.light)
    }
}

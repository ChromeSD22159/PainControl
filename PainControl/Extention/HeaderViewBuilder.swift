//
//  HeaderViewBuilder.swift
//  PainControl
//
//  Created by Frederik Kohler on 09.02.22.
//

import SwiftUI

//HeaderViewBuilder(title: tabBarManager.selectedTabName)

enum HeaderState: String {
    case DateTitle
    case NameTitle
    case withoutIcons
}

struct Header<Content: View>: View {
   
    var type:HeaderState
    var title: String
    var titleFontSize: Font
    private let builder: () -> Content
    
    init(
        type:HeaderState = .DateTitle,
        title:String = "AppTitle",
        titleFontSize: Font = .title3,
        @ViewBuilder _ builder: @escaping () -> Content
    ){
        self.type = type
        self.title = title
        self.titleFontSize  = titleFontSize
        self.builder = builder
    }
    
    var body: some View {
        
        switch type {
        case .DateTitle: DateTitleHeader(title: title, titleFontSize: titleFontSize) { builder() }
        case .NameTitle: DateTitleHeader(title: title, titleFontSize: titleFontSize) { builder() }
        case .withoutIcons: DateTitleHeader(title: title, titleFontSize: titleFontSize) { builder() }
        }
    }
}

struct DateTitleHeader<Content: View>: View {
    let title:String
    let titleFontSize: Font
    private let builder: () -> Content
    
    init(
        title:String = "AppTitle",
        titleFontSize:Font = .title3,
    @ViewBuilder _ builder: @escaping () -> Content
    ){
        self.title = title
        self.titleFontSize = titleFontSize
        self.builder = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 20){
                VStack(alignment: .leading ,spacing: 0){
                    Text(Date(), style: .date)
                        .font(.footnote)
                    Text(title)
                        .font(titleFontSize)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    HStack(spacing: 0){
                        Spacer()
                        
                        builder()
                    }
                }
            }
        }
        .padding()
        .padding(.horizontal)
        .padding(.top, 50)
        .frame(maxWidth: .infinity)
        .background(
            // TABBAR BACKGROUND
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 15, style: .continuous)
        )
    }
}


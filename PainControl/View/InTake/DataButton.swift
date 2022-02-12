//
//  DataButton.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import SwiftUI

struct DataButton: View {
    var title : String
    var innerPadding: CGFloat = 5
    
    @EnvironmentObject var inTakeManager: inTakeViewModel
    
    var body: some View {
        
        Button(action: {
            inTakeManager.updateDate(value: title)
        }, label: {
            
            VStack {
                Text(title)
                    .font(.system(size: 10))
                    .padding(.vertical, innerPadding)
                    .padding(.horizontal, innerPadding * 2)
                    .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                    .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                    .cornerRadius(10)
                
                Group {
                    switch title {
                    case "morgens":
                        Image(systemName: "sun.and.horizon")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                            .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                           
                    case "mittags":
                        Image(systemName: "sun.min")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                            .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                          
                    case "abends":
                        Image(systemName: "sunset")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                            .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                            
                    case "nachts":
                        Image(systemName: "moon.stars")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                            .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                                
                    default:
                        Image(systemName: "sun.min")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(inTakeManager.checkDate() == title ? .white : .gray)
                            .lineaGradientBackground(colors: inTakeManager.checkDate() == title ? [.orange,.pink] : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                            
                    }
                       
                }
            }
            
        })
    }
}

struct DataButton_Previews: PreviewProvider {
    static var previews: some View {
        DataButton(title: "Heute")
    }
}

//
//  DrugButton.swift
//  PainControl
//
//  Created by Frederik Kohler on 02.02.22.
//

import SwiftUI

struct DrugButton: View {
    var title : String
    var innerPadding: CGFloat = 5
    
    @EnvironmentObject var drugManager: drugViewModel
    
    var body: some View {
        let LinearGradient:[Color] = [.teal,.teal]
        
        Button(action: {
            drugManager.updateState(value: title)
        }, label: {
            
            VStack {
               
                Group {
                    switch title {
                    case "morgens" :
                        Text(title)
                            .font(.system(size: 10))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.morning ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.morning ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                        Image(systemName: "sun.and.horizon")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.morning ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.morning ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                        
                    case "mittags" :
                        Text(title)
                            .font(.system(size: 10))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.noon ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.noon ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                        Image(systemName: "sun.min")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.noon ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.noon ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                    case "abends" :
                        Text(title)
                            .font(.system(size: 10))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.evening ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.evening ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                        Image(systemName: "sunset")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.evening ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.evening ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                    case "nachts" :
                        Text(title)
                            .font(.system(size: 10))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.night ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.night ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                        Image(systemName: "moon.stars")
                            .font(.system(size: 24))
                            .padding(.vertical, innerPadding) 
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(drugManager.night ? .white : .gray)
                            .lineaGradientBackground(colors: drugManager.night ? LinearGradient : [.white], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                        
                    default:
                        Text(title)
                            .font(.system(size: 10))
                            .padding(.vertical, innerPadding)
                            .padding(.horizontal, innerPadding * 2)
                            .foregroundColor(.red)
                            .lineaGradientBackground(colors: [.red], startPoint: .topTrailing, endPoint: .bottomLeading)
                            .cornerRadius(10)
                    }
                }

            }
            
        })
    }
}

 
 struct DrugButton_Previews: PreviewProvider {
     static var previews: some View {
         DrugButton(title: "Ibu").environmentObject(drugViewModel())
     }
 }


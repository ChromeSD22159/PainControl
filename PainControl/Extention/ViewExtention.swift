//
//  ViewExtentions.swift
//  PainControl
//
//  Created by Frederik Kohler on 01.02.22.
//

import SwiftUI

extension View {

    /// This function returns a welcoming string for a given `subject`.
    ///
    /// ```
    /// .lineaGradientBackground(colors: [.orange,.pink], startPoint: .topTrailing, endPoint: .bottomLeading)
    /// ```
    /// - Parameters:
    ///   - colors: <#colors description#>
    ///   - startPoint: <#startPoint description#>
    ///   - endPoint: <#endPoint description#>
    /// - Returns: <#description#>
    public func lineaGradientBackground(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View{
        return self.background(
            LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
        )
    }
    

    /// This function returns a welcoming string for a given `subject`.
    ///
    /// ```
    /// .cornerRadius(20, corners: [.topLeft, .bottomRight])
    /// ```
    /// - Parameters:
    ///   - radius: CGFloat
    ///   - corners: UIRectCorner
    /// - Returns: description
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
           clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    
    func dynamicFontSize(padding: Int, devider: Int) -> some View {
        let viewPort = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let divider = Int(viewPort.width) / devider

        return self.frame(maxWidth: CGFloat(divider - (padding * 2)) )
    }
    
    
    /// This function returns a welcoming string for a given `subject`.
    ///
    /// ```
    /// DrugCountHeightForList(text: "\(Drugs.count)", font: UIFont.systemFont(ofSize: 17), width: 300, padding: 10, showPrint: true)
    /// DrugCountHeightForList(text: "\(Drugs.count)", font: UIFont.preferredFont(forTextStyle: .largeTitle), width: 300, padding: 10, showPrint: true)
    /// ```
    /// - Parameters:
    ///   - text: Get Text width & height (CGFloat)
    ///   - font: Get Font height (CGFloat)
    ///   - width: Get Text width & height (CGFloat)
    ///   - padding: Add padding to calc (Add all Paddings together)
    /// - Returns: description
    func DrugCountHeightForList(multiplie: CGFloat, text:String, font:UIFont, width:CGFloat, paddings:CGFloat) -> CGFloat {
        // To calculate height for label based on text size and width
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.font = font
        label.text = text

        label.sizeToFit()
        
        /*
         let fontPadding = CGFloat(20)
         let rowPadding = CGFloat(2) * padding
         let listViewPadding = CGFloat(2 * 10)
         
         let rowHeight = listViewPadding + fontPadding + rowPadding + label.frame.height
         */
        
        let rowHeight = paddings + label.frame.width
        
        return rowHeight * CGFloat(multiplie)
    }
    
    // get Types of items
    func printType(_ input: Any){
        let type = type(of: input)
        print("\(input) is a type of `\(type))` ")
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


/* Spacer Custom to Top */
struct TopSpacer: View {
    let height: CGFloat
    
    init(height:CGFloat = 150){
        self.height = height
    }

    var body: some View {
        Text("")
            .padding(.top, height)
    }
}


struct AppLogo /* <Content: View> */ : View {
    let name:String
    let iconName: String
    let imageName: String
    //let content: Content

    init(
        name:String = "App",
        iconName:String = "house",
        imageName:String = ""
        //@ViewBuilder content: () -> Content
    ){
        self.name = name
        self.iconName = iconName
        self.imageName = imageName
        //self.content = content()
    }
    
    var body: some View {
        HStack{
            
            if imageName == ""{
                HStack{
                    Image(systemName: iconName)
                    Text("\(name)")
                }
            }
            
            if imageName.count >= 1 {
               
                if (UIImage(named: imageName) != nil) {
                    // "Image existing"
                    HStack{
                        Image("\(imageName)")
                        Text("\(name)")
                    }
                }
                else {
                    // "Image is not existing"
                    HStack{
                        Image(systemName: iconName)
                        Text("\(name)")
                    }
                    .onAppear {
                        print("APP Logo is not existing")
                    }
                }
                
            }
            
            
        }
    }
    
}
 
 /*
 
 struct AppLogo: View {
     let name: String
     let iconName?: String = "pills"
     let image?: String = ""
     
     var body: some View {
         HStack{
             Image(systemName: iconName)
             
             Text("\(name)")
         }
     }
 }
 */



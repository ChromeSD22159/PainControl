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
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

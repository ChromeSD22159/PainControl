//
//  flashIcon.swift
//  PainControl
//
//  Created by Frederik Kohler on 06.02.22.
//

import SwiftUI

struct flashIcon: View {
    var body: some View {
        // width="44" height="62"
        flashIconShape()
            .fill(.yellow)
            .frame(width: 44, height: 62)
    }
}

struct flashIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.65358*width, y: 0.03074*height))
        path.addCurve(to: CGPoint(x: 0.06756*width, y: 0.52556*height), control1: CGPoint(x: 0.6166*width, y: 0.06166*height), control2: CGPoint(x: 0.10549*width, y: 0.49463*height))
        path.addCurve(to: CGPoint(x: 0.0979*width, y: 0.58876*height), control1: CGPoint(x: 0.02963*width, y: 0.55649*height), control2: CGPoint(x: 0.04101*width, y: 0.58876*height))
        path.addLine(to: CGPoint(x: 0.45824*width, y: 0.58876*height))
        path.addCurve(to: CGPoint(x: 0.27618*width, y: 0.93029*height), control1: CGPoint(x: 0.45824*width, y: 0.58876*height), control2: CGPoint(x: 0.30083*width, y: 0.88323*height))
        path.addCurve(to: CGPoint(x: 0.36341*width, y: 0.97064*height), control1: CGPoint(x: 0.25152*width, y: 0.97736*height), control2: CGPoint(x: 0.32738*width, y: 1.00022*height))
        path.addCurve(to: CGPoint(x: 0.94375*width, y: 0.47984*height), control1: CGPoint(x: 0.39945*width, y: 0.94105*height), control2: CGPoint(x: 0.90013*width, y: 0.5148*height))
        path.addCurve(to: CGPoint(x: 0.92668*width, y: 0.41261*height), control1: CGPoint(x: 0.98737*width, y: 0.44489*height), control2: CGPoint(x: 0.96461*width, y: 0.41261*height))
        path.addLine(to: CGPoint(x: 0.55686*width, y: 0.41261*height))
        path.addCurve(to: CGPoint(x: 0.74082*width, y: 0.07242*height), control1: CGPoint(x: 0.55686*width, y: 0.41261*height), control2: CGPoint(x: 0.71308*width, y: 0.12486*height))
        path.addCurve(to: CGPoint(x: 0.65358*width, y: 0.03074*height), control1: CGPoint(x: 0.76855*width, y: 0.01998*height), control2: CGPoint(x: 0.69056*width, y: -0.00019*height))
        path.closeSubpath()
        return path
    }
}

struct flashIcon_Previews: PreviewProvider {
    static var previews: some View {
        flashIcon()
    }
}

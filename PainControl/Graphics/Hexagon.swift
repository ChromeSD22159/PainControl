//
//  Hexagon.swift
//  PainControl
//
//  Created by Frederik Kohler on 11.02.22.
//

import Foundation
import SwiftUI
import CoreGraphics

struct HexagonStruct {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20 + adjustment),
            curve:   CGPoint(x: 0.00, y: 0.30 + adjustment),
            control: CGPoint(x: 0.00, y: 0.25 + adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70 - adjustment),
            curve:   CGPoint(x: 0.05, y: 0.80 - adjustment),
            control: CGPoint(x: 0.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80 - adjustment),
            curve:   CGPoint(x: 1.00, y: 0.70 - adjustment),
            control: CGPoint(x: 1.00, y: 0.75 - adjustment)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30 + adjustment),
            curve:   CGPoint(x: 0.95, y: 0.20 + adjustment),
            control: CGPoint(x: 1.00, y: 0.25 + adjustment)
        )
    ]
}

struct HexagonComponent: View {
    var body: some View {
        GeometryReader { geometry in
            let path = Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonStruct.adjustment)
                    )
                )

                HexagonStruct.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )

                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
                
                //path.addArc(center: CGPoint(x: 100, y: 300), radius: 200, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.closeSubpath()
            }
            path.overlay(
                path.stroke(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.7),
                            .white.opacity(0.1),
                        ], startPoint: .topLeading, endPoint: .bottomTrailing
                    ), lineWidth: 10)
                    
            )
            
            path.fill(.white)
           
            path.fill(
                LinearGradient(
                    colors: [
                        Color("button").opacity(0.8),
                        Color("button").opacity(0.5),
                        Color("button").opacity(0.7),
                        Color("button").opacity(0.9),
                        Color("button").opacity(1),
                        Color("button").opacity(0.9),
                        Color("button").opacity(0.7),
                        Color("button").opacity(0.5),
                        Color("button").opacity(0.4),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

struct Hexagon_Previews: View {
    var body: some View {
        ZStack{
            
            HexagonComponent()
                .frame(width: 100, height: 100)
            
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
    }
}

struct Hexagon_Previews_Previews: PreviewProvider {
    static var previews: some View {
        Hexagon_Previews()
    }
}

/*
color:

 [
     Color("PainControlCardText").opacity(0.1),
     Color("PainControlCardText").opacity(0.3),
     Color("PainControlCardText").opacity(0.5),
     Color("PainControlCardText").opacity(0.6),
     Color("PainControlCardText").opacity(0.6),
     Color("PainControlCardText").opacity(0.6),
     Color("PainControlCardText").opacity(0.5),
     Color("PainControlCardText").opacity(0.3),
     Color("PainControlCardText").opacity(0.1),
 ]
 */

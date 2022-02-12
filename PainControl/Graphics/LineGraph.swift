//
//  graph.swift
//  PainControl
//
//  Created by Frederik Kohler on 05.02.22.
//

import SwiftUI

struct graph: View {
    
    var data: [Int] = [9,8,7,5,8,2,3,6,4,8]
    
    var body: some View {
        Text("")
        /*
        VStack {
            ForEach(data) { drug in
                Text("\(drug!)")
            }
          
             LineGraph(data: data)
                 .frame(height: 250)
                 .frame(maxWidth: .infinity)
             
        }
         */
    }
}


struct LineGraph: View {
    var data: [Int]

    @State var currentPlot: String = "0"
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
    @State var ViewWidth:CGFloat = UIScreen.main.bounds.size.width
    
    var body: some View {
        GeometryReader { proxy in
 
            // Convert incomming Array
            let convertedArray = data.map {
                CGFloat(($0 as NSNumber).doubleValue)
            }
            
            // View Size
            let height = proxy.size.height                              // '22.941176470588236' of type 'CGFloat'
            let width = (proxy.size.width) / CGFloat(convertedArray.count)        // '250.0' of type 'CGFloat'
            
            // find the Largest Point and add +100
            let maxPoint = (convertedArray.max() ?? 0) + 5                      // '1700.0' of type 'CGFloat'
            
            /* 'EnumeratedSequence<Array<CGFloat>>(_base: [989.0, 1200.0, 750.0, 790.0, 650.0, 950.0, 1200.0, 600.0, 500.0, 600.0, 890.0, 1283.0, 1400.0, 900.0, 1250.0, 1600.0, 1200.0])' of type 'EnumeratedSequence<Array<CGFloat>>' */
            let points = convertedArray.enumerated().compactMap { item -> CGPoint in
                // Print(item) // '(offset: 0, element: 989.0)' of type '(offset: Int, element: CGFloat)'

                 let progress = item.element / maxPoint                 // 989.0 / 1700

                 let pathHeight = progress * height                     // 13,322
                 
                 let pathWidth = width * CGFloat(item.offset)
                
                 return CGPoint(x: pathWidth, y: -pathHeight + height )
            }
            
            
            
            
            ZStack {

                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    for point in points {
                      path.addLine(to: point)
                    }
                }
                .strokedPath(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [.red,.blue], startPoint: .leading, endPoint: .trailing))
                .onAppear {
                    let px = CGFloat(points.last!.x)
                    let py = CGFloat(points.last!.y)
                    // print(data)
                    offset = CGSize(width: px - 40, height: py - height)
                    
                    let index = max(min(Int((px / width).rounded() + 1), convertedArray.count - 1), 0)
                    currentPlot = "\(convertedArray[index])"
                    print(convertedArray[index])
                }
                .onChange(of: points) { newPoints in
                    let px = CGFloat(newPoints.last!.x)
                    let py = CGFloat(newPoints.last!.y)
                    // print(data)
                    offset = CGSize(width: px - 40, height: py - height)
                    
                    let index = max(min(Int((px / width).rounded() + 1), convertedArray.count - 1), 0)
                    currentPlot = "\(convertedArray[index])"
                }
                
               FillBG()
                    .clipShape(
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            for point in points {
                              path.addLine(to: point)
                            }
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: proxy.size.height))
                        }
                    )
                    .padding(.top, 15)
                   
            } // ZStack
            .overlay(
                Overlay(currentPlot: $currentPlot, offset: $offset, translation: $translation, ViewWidth: $ViewWidth, showPlot: $showPlot)
                    // for gesture calculation
                    .frame(width: 80, height: 170)
                    // 170 / 2 = 85 - 15 => Circlering Size...
                    .offset(y: 70)
                    .offset(offset),
                alignment: .bottomLeading
            )
            //.contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                           
                            showPlot = true
                            
                            let translation = value.location.x
                            
                            let index = max(min(Int((translation / width).rounded() + 1), convertedArray.count - 1), 0)
                            
                            currentPlot = "\(convertedArray[index])"
                            self.translation = translation
                            
                            offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                        }
                    }).onEnded({ value in
                        withAnimation { showPlot = false }
                    }))

            
        } // GeometryReader
        
    } // View
    
}

struct Overlay: View {
    @Binding var currentPlot: String
    @Binding var offset: CGSize
    @Binding var translation: CGFloat
    @Binding var ViewWidth:CGFloat
    @Binding var showPlot:Bool
    
    var body: some View {
        VStack(spacing: 5){
            
            Label(currentPlot, systemImage: "bolt.fill")
                .font(.caption.bold())
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background( .red, in: Capsule() )
                .offset(x: translation < 10 ? 30 : 0)
                .offset(x: translation > (ViewWidth - 60) ? -30 : 0)
            
            Rectangle()
                .fill(.red)
                .frame(width: 1, height: 50)
            
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
                .overlay(
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(.white)
                )
            
            Rectangle()
                .fill(.red)
                .frame(width: 1, height: 50)
            
        }
        //.opacity(showPlot ? 1 : 0)
    }
}

extension View {
    public func FillBG() -> some View {
        LinearGradient(
            colors: [
                .blue.opacity(0.3),
                .pink.opacity(0.2),
                .pink.opacity(0.1)] + Array(repeating: .blue.opacity(0.1), count: 4) + Array(repeating: Color.clear, count: 2),
            startPoint: .top,
            endPoint: .bottom)
    }

    public var viewWidth: CGFloat {
        let bounds = UIScreen.main.bounds
        return bounds.size.width
    }

    public var viewHeight: CGFloat {
        let bounds = UIScreen.main.bounds
        return bounds.size.height
    }
}


struct graph_Previews: PreviewProvider {
    static var previews: some View {
        graph()
    }
}

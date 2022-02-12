//
//  LaunchScreen.swift
//  PainControl
//
//  Created by Frederik Kohler on 10.02.22.
//

import SwiftUI

struct LaunchScreen: View {
    @State var animatePill = false
    @State var animateText = false
    @State var animateCircle = false
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(
                colors: [Color("darkBlue"), Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing
            )
                
            
            ZStack{
                
                Circle()
                    .fill(.white)
                    .opacity(animateCircle ? 1 : 0)
                    .frame(width: animateCircle ? 1500 : 0, height: animateCircle ? 1500 : 0)
                    //.frame(width: 1200, height: 1200)
       
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack{
                
                Spacer()
                
                ZStack{
                    Image("pills")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: animatePill ? 150 : 100)
                        .offset(y: animatePill ? 0 : -500)
                }
                
                
                Text("PainControl")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.white)
                    .opacity(animateText ? 1 : 0)
                    
                Spacer()
                
                HStack(spacing: 10){
                    Image("FKLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                    
                    Text("Frederik Kohler")
                }
                .font(.footnote.weight(.semibold))
                .foregroundColor(.white)
                .padding(.bottom, 30)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .onAppear(perform: animation)
        .ignoresSafeArea(.all)
        
        
    }
    
    func animation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            withAnimation(Animation.easeIn(duration: 1)){
                animatePill.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(Animation.easeIn(duration: 0.5)){
                animateText.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            withAnimation(Animation.easeIn(duration: 0.5)){
                animatePill.toggle()
                animateCircle.toggle()
            }
            animateCircle.toggle()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}

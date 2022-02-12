//
//  CardView.swift
//  PainControl
//
//  Created by Frederik Kohler on 10.02.22.
//

import SwiftUI

struct CardView: View {
    
    @Namespace var namespace
    @State private var show:Bool = false
    @State private var contentText:Bool  = false
    var body: some View {
        
        VStack{
            ZStack{
                
                if !show {
                    CardItem(namespace: namespace, show: $show, contentText: $contentText)
                        .onTapGesture {
                            withAnimation(.spring()){
                                show.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                                withAnimation(Animation.easeInOut(duration: 0.25)){
                                    contentText.toggle()
                                }
                            }
                        }
                } else {
                    CardDetailView(namespace: namespace, show: $show, contentText: $contentText)
                }
    
            }
            
        }
        
    }
}

struct CardView_preview: PreviewProvider {
    
    static var previews: some View {
        CardView()
    }
}


struct CardItem: View {
    var namespace: Namespace.ID
    @Binding var show:Bool
    @Binding var contentText:Bool
    
    var body: some View{
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("CardItem01")
                    .font(.body.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                Text("20 Sections - 30 Hours".uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subTitle", in: namespace)
                Text("Building an iOS app for iOS 15 with custom Layouts, animaten and ...")
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "text", in: namespace)
            }
            .padding()
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(
                        RoundedRectangle(cornerRadius:30, style: .continuous)
                    )
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image("painImage-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        )
        .frame(height: 300)
        .padding(.vertical)
    }
    
    /*
     struct CardItem_Previews: PreviewProvider {
         @Namespace static var namespace
         
         static var previews: some View {
             CardItem(namespace: namespace, show: .constant(true), contentText: .constant(true))
         }
     }
     */
    
}





struct CardDetailView: View {
    var namespace: Namespace.ID
    @Binding var show:Bool
    @Binding var contentText:Bool
        
    var body: some View{
        ZStack{
            
            ScrollView {
                VStack {
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .frame(minHeight: 300)
                .padding(20)
                .foregroundStyle(.white)
                
                .background(
                    Image("painImage-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background", in: namespace)
                    
                )
                .mask(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                )
                .overlay(
                    VStack(alignment: .leading, spacing: 12){
                        Text("Building an iOS app for iOS 15 with custom Layouts, animaten and ...")
                            .font(.footnote.weight(.semibold))
                            .matchedGeometryEffect(id: "text", in: namespace)
                        
                        Text("20 Sections - 30 Hours".uppercased())
                            .font(.footnote.weight(.semibold))
                            .matchedGeometryEffect(id: "subTitle", in: namespace)
                        
                        Text("CardItem01")
                            .font(.largeTitle.weight(.bold))
                            .matchedGeometryEffect(id: "title", in: namespace)
                        
                        VStack(alignment: .leading, spacing: 12){
                            Label("PainControl", systemImage: "pills")
                            Divider()
                            Label("PainControl Pro", systemImage: "star")
                            Divider()
                            Label("Your account", systemImage: "folder.circle")
                        }
                    }
                    .padding(20)
                    .foregroundStyle(.primary)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(
                                RoundedRectangle(cornerRadius:30, style: .continuous)
                            )
                            .matchedGeometryEffect(id: "blur", in: namespace)
                    )
                        .padding()
                    .offset(y: 250)
                )
                
                
                 VStack(alignment: .leading, spacing: 30){
                     Text("Liebe Leserin, lieber Leser,")
                         .font(.body.weight(.semibold))
                     
                     Text("ob im Einsatz für Webanwendungen, Mobile oder Desktop, auf Unternehmensservern oder auf dem Raspberry Pi: Node.js spielt mittlerweile in allen Bereichen eine große Rolle. Node.js-Anwendungen gelten als äußerst performant, skalierbar und plattformunabhängig. Der Teufel steckt im Detail: für ein tiefes Verständnis der Entwicklungsplattform ist neben guten JavaScript-Kenntnissen viel Praxis nötig.")

                      Text("Dieses Praxiswissen bieten wir Ihnen in unseren neuen Online-Seminaren zu Node.js. Sie lernen unter Leitung des Web- und Softwareentwicklers Sebastian Springer in extra kleinen Seminargruppen – so bleibt stets genügend Raum für intensives Üben und Ihre Fragen.")

                     Text("Entdecken Sie jetzt unser Seminarangebot. Wir freuen uns auf Sie!")
                 }
                 .padding(.top, 250)
                 .padding(.bottom, 100)
                 .padding(.horizontal)
                 .opacity(contentText ? 1 : 0)

                
            }
            
            VStack {
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)){
                        contentText.toggle()
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.black)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
        }
    }
   
    /*
     struct CardDetailView_preview: PreviewProvider {
         @Namespace static var namespace
         
         static var previews: some View {
             CardItem(namespace: namespace, show: .constant(true), contentText: .constant(true))
         }
     }
     */
    
}



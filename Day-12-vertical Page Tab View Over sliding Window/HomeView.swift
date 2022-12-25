//swiftUI 2.0
//  HomeView.swift
//  Day-12-vertical Page Tab View Over sliding Window
//
//  Created by Apple  on 25/12/22.
//

import SwiftUI

struct HomeView: View {
    //page tabbar view has a bug that it bounces ...
    //but we have solution for that
    //but it disables all bounces in whole app
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    @State var currentPage:Int = 2
    var body: some View {
        
        
        ScrollView(.init()){
           
            TabView{
                
                GeometryReader { proxy in
                    let screen = proxy.frame(in: .global)
                    
                    //oversliding animation
                    let offset = screen.minX
                    let scale = 1 - (offset/screen.width)
                    TabView(selection: $currentPage){
                        ForEach(2...6,id:\.self){index in
                            
                            Image("img\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:getRect().width).cornerRadius(1)
                                .modifier(VerticalTabBarViewModifier(screen: screen))
                                .tag(index)
                            
                            
                            
//                                .modifier(VerticalTabBarViewModifier(screen: screen))

                                
                            
                        }
                    }
                    //page tabbar
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    //vertical tabbar#r1
                    .rotationEffect(.init(degrees: 90))
                    //adjusting width
                    .frame(width: screen.width)
                    
                    //oversliding effect
                    .offset(x: -offset)
                    .scaleEffect(scale >= 0.88 ? scale : 0.88 ,anchor: .center)
                    .offset(x: -offset)
                    .blur(radius: (1-scale)*20)
                
                    
                }
                
                DetailView(currentPage: $currentPage)
            }
            .background(Color.black)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
       
        .ignoresSafeArea()
    }
}

//extenting view to get rect...

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct VerticalTabBarViewModifier:ViewModifier{
    var screen:CGRect
    func body(content: Content) -> some View {
        return content
        //rerotating views for -90 so that it willact as vertical carousel...
            //before rotation frame
            .frame(width: screen.width,height: screen.height)
            .rotationEffect(Angle(degrees: -90))
             //after rotation
            .frame(width: screen.height,height: screen.width)
        
        
    }
}

struct DetailView:View{
    @Binding var currentPage:Int
    var colors:[Color] = [.red, .gray, .green, .yellow, .blue,.white,.orange,.pink]
    
    var body:some View{
        VStack{
            Text("Details")
                .font(.title.bold())
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(20)
            Image("img\(currentPage)")
                .resizable()
                
                .frame(width: 250,height: 250)
                .aspectRatio(contentMode: .fit)
                .padding()
                
            
            Spacer()
        }
        .background(colors[currentPage].blur(radius: 70))
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

//edges
var edges = UIApplication.shared.windows.first?.safeAreaInsets

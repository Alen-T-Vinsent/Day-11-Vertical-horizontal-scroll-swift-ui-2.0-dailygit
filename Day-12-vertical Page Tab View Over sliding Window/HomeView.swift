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
    var body: some View {
        
        
        ScrollView(.init()){
            
            GeometryReader { proxy in
                let screen = proxy.frame(in: .global)
                TabView{
                    ForEach(1...5,id:\.self){index in
                        
                        Image("hold on")
                            .resizable()
                            .background(Color.red)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:getRect().width)
                            .cornerRadius(1)
                        //rerotating views for -90 so that it willact as vertical carousel...
                            //before rotation frame
                        //just checking
                            .overlay(
                                VStack{
                                    Text("Hello")
                                    Spacer()
                                    HStack{
                                        Text("Hello")
                                        Spacer()
                                        Text("Hello")
                                    }
                                    Spacer()
                                    Text("Hello")
                                })
                            .frame(width: screen.width,height: screen.height)
                            .rotationEffect(Angle(degrees: -90))
                             //after rotation
                            .frame(width: screen.width,height: screen.height)
                        
                    }
                }
                //page tabbar
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                //vertical tabbar#r1
                .rotationEffect(.init(degrees: 90))
                //adjusting width
                .frame(width: screen.width)
            }
            
        }
       
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

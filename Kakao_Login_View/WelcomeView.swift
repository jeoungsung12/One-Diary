//
//  WelcomeView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var go: Bool = false
    @State private var hasTimeElapsed = false
    var body: some View {
        NavigationView{
            VStack{
                NavigationView(){
                    LottieView(filename: "welcome")
                }.padding()
                NavigationLink(destination: TextView().navigationBarBackButtonHidden(true), isActive: $go){}.task(delayNext)
                }
//                NavigationLink(destination: LoginView()
//                    .navigationBarBackButtonHidden(true),
//                               label: {Text("시작하기")})
//                .padding(.horizontal)
//                .frame(width: 180, height: 35)
//                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
            }.padding()
        }
    private func delayNext() async{
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        hasTimeElapsed = true
        go = true
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

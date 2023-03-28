//
//  ContentView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/03.
//WEDLE(우리들)

import SwiftUI
import Combine

struct ContentView: View {
    @State private var go: Bool = false
    @State private var hasTimeElapsed = false
    @State private var isLoggedIn: Bool = false
    @StateObject var result : send = send()
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationView(){
                    LottieView(filename: "plant")
                }.padding()
                Text("한 줄의 기록을 담다").foregroundColor(.gray)
                    .font(.system(size: 20))
                Spacer()
//                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $go){}.task(delayNext)
                if !isLoggedIn{
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $go){}.task(delayNext)
                }else{
                    NavigationLink(destination: TextView().navigationBarBackButtonHidden(true), isActive: $go){}.task(delayNext)
                }
            }
        }.padding()
    }
    private func delayNext() async{
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        hasTimeElapsed = true
        go = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

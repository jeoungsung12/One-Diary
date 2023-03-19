//
//  LoginView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
struct LoginView: View {
    @StateObject var kakaoAuthVM : KakaoAuthVM = KakaoAuthVM()
    @State private var go_to: Bool = true
    let login = "로그인 상태"
    let logout = "로그아웃 상태"
    let loginStatusInfo : (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    var body: some View {
//        List(quotes, id: \.id) { quote in }
        NavigationView{
            VStack{
                Text(loginStatusInfo(kakaoAuthVM.isLoggedIn)).padding(.leading, 200.0)
                NavigationView(){
                    LottieView(filename: "jolove")
                }
                VStack{
                    Button("카카오 로그인", action: {kakaoAuthVM.handleKakaoLogin()})
                        .frame(width: 230, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    if(loginStatusInfo(kakaoAuthVM.isLoggedIn) == login){
                        NavigationLink(destination: TextView(), isActive: $go_to){
                            //.navigationBarBackButtonHidden(true)
                        }
                    }
                    Button("카카오 로그아웃", action: {kakaoAuthVM.kakaoLogout()})
                        .frame(width: 230, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                }.padding()
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

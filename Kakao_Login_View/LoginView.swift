//
//  LoginView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
var div : Bool = false
struct LoginView: View {
    @StateObject var kakaoAuthVM : KakaoAuthVM = KakaoAuthVM()
    @State private var go_to: Bool = true
    let login = "로그인 상태"
    let logout = "로그아웃 상태"
    let loginStatusInfo : (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    @State private var isLoggedIn_ : Bool = false
    @State private var autoToken : String = ""
    let userDefaults = UserDefaults.standard
    @State private var authToken: String = ""
    @State private var isLoggedIn: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                Text(loginStatusInfo(kakaoAuthVM.isLoggedIn)).padding(.leading, 200.0)
                NavigationView(){
                    LottieView2(filename: "hello")
                }
                VStack{
                    Button("카카오 로그인", action: {kakaoAuthVM.handleKakaoLogin()})
                        .frame(width: 230, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
//                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.2)
                    if(loginStatusInfo(kakaoAuthVM.isLoggedIn) == login){
                        NavigationLink(destination: WelcomeView().navigationBarBackButtonHidden(true), isActive: $go_to){
                        }
                    }
                    Button("카카오 로그아웃", action: {kakaoAuthVM.kakaoLogout()})
                        .frame(width: 230, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
//                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0.2)
                }.padding()
            }.padding()
        }.onAppear{
            if let authToken = UserDefaults.standard.string(forKey: "AuthToken"){
                self.authToken = kakaoAuthVM.actoken
                print(authToken)
                div = true
            }
        }.onDisappear{
            UserDefaults.standard.set(authToken, forKey: "AuthToken")
        }
    }
}
class send : ObservableObject {
    var send : Bool = div
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

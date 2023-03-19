//
//  KakaoAuthVM.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/03.
//

import Foundation
import Combine
import KakaoSDKUser
import KakaoSDKAuth
import Alamofire
var access : String = ""
class KakaoAuthVM : ObservableObject{
    @Published var isLoggedIn : Bool = false
    @Published var manager = Userid_Post()
    @Published var token : String = ""
    @Published var snsType : String = "KAKAO"
    @Published var actoken : String = "Bearer "
    
    func kakaoLogout(){
        Task{
            if await handleKakaoLogout(){
                isLoggedIn = false
            }
        }
    }
    func handleKakaoLogout() async -> Bool{
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    func handleLoginWithKakaoTalkApp() async -> Bool{
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk { [self](oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
                    self.token += oauthToken?.accessToken ?? ""
                    self.manager.checkDeatils(authToken: self.token, snsType: self.snsType)
                    continuation.resume(returning: true)
                }
            }
        }
    }
    func handleWithKakaoAccount() async -> Bool {
        await withCheckedContinuation{ continunation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                        continunation.resume(returning: false)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                        self.token += oauthToken?.accessToken ?? ""
                        self.manager.checkDeatils(authToken: self.token, snsType: self.snsType)
                        continunation.resume(returning: true)
                    }
                }
        }
    }
    func handleKakaoLogin(){
        Task{
            // 카카오톡 실행 가능 여부 확인 - 설치 되어있을때
            if (UserApi.isKakaoTalkLoginAvailable()) {
                //카카오 앱을 통해 로그인
                isLoggedIn = await handleLoginWithKakaoTalkApp()
            }
            else{ //설치 되어있지 않을때
                //카카오 웹뷰로 로그인
                isLoggedIn = await handleWithKakaoAccount()
            }
        }
    }
}
class Userid_Post: ObservableObject{
        var didChange = PassthroughSubject<Userid_Post, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
        func checkDeatils(authToken : String, snsType : String){
            var get = Userid()
            let body: [String: Any] = ["authToken": authToken, "snsType" : snsType]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            let url = URL(string: "http://52.78.241.137:8080/auth/login")!
            //http://52.78.241.137:8080/auth/login
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            print(body)
            print(jsonData)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    access = responseJSON["accessToken"] as! String
                    access = "Bearer " + access
                    get.check(accessToken: access)
                    print(access)
                    print(responseJSON)
                }
            }
            task.resume()
        }
}
class Userid: ObservableObject{
        var didChange = PassthroughSubject<Userid, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
        func check(accessToken : String){
//            let body: [String: Any] = ["accessToken": accessToken]
//            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            let url = URL(string: "http://52.78.241.137:8080/users/me")!
            //http://52.78.241.137:8080/auth/login
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
//            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
//            request.httpBody = jsonData
            
//            print(body)
//            print(jsonData)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            task.resume()
        }
}

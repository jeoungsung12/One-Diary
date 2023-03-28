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
var id_ : Int64 = 0
var shareToken : String = ""
var text : String = ""
class KakaoAuthVM : ObservableObject{
    @Published var isLoggedIn : Bool = false
    @Published var manager = Userid_Post()
    @Published var token : String = ""
    @Published var snsType : String = "KAKAO"
    @Published var actoken : String = "Bearer "
    @Published var send : String = ""
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
    @Published var value: Int = 0
    private var cancellables = Set<AnyCancellable>()
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
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }

                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        guard var access = responseJSON["accessToken"] else {
                            return
                        }
                        access = responseJSON["accessToken"] as! String
                        //print(access)
                        //print(responseJSON)
                        get.check(accessToken: access as! String)
                    }
                }
                task.resume()
            }
        }
}
class Userid: ObservableObject{
    @Published var A : Int64 = 0
    private var cancellables = Set<AnyCancellable>()
        var didChange = PassthroughSubject<Userid, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
        func check(accessToken : String){
            var g = DataPost_()
//            let body: [String: Any] = ["accessToken": accessToken]
//            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            let url = URL(string: "http://52.78.241.137:8080/users/me")!
            //http://52.78.241.137:8080/auth/login
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            var AT : String = "Bearer "
            AT = AT + accessToken
            print(AT)
            shareToken = AT
            request.setValue(AT, forHTTPHeaderField: "Authorization")

            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request)
                { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        guard var id_ = responseJSON["result"] else {
                            return
                        }
                        id_ = responseJSON["result"] as! Int64
                        print(id_)
                        g.find_id(i : id_ as! Int64)
                    }
                }
                task.resume()
            }
        }
}
class DataPost_: ObservableObject{
    //@ObservedObject var share : IdShare = IdShare()
        var didChange = PassthroughSubject<DataPost_, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func find_id(i : Int64) {
        id_ = i
    }
    func checkDeatils(year : String, feel : String, weather : String, short : String){
        let body: [String: Any] = ["diaryDate": year, "contents" : feel, "lengthFlag" : short]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
//            var r : Int64 = share.id_share
            let url = URL(string: "http://52.78.241.137:8080/users/\(id_)/diary/content")!
            //http://52.78.241.137:8080/auth/login
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(shareToken, forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            print(url)
            print(id_)
            print(body)
            print(jsonData)
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
class IdShare : ObservableObject {
    @Published var id_share = id_
    @Published var s_t = shareToken
}
class DataPost3: ObservableObject{
        var didChange = PassthroughSubject<DataPost3, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func checkDeatils(year : String , story3 : String, weather : String, Long : String){
        let body: [String: Any] = ["diaryDate" : year, "contents" : story3,  "lengthFlag" : Long]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            let url = URL(string: "http://52.78.241.137:8080/users/\(id_)/diary/content")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(shareToken, forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            print(id_)
            print(body)
            print(jsonData)
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

class DataGet4: ObservableObject{
    @Published var v : String = ""
    @Published var b : Int64 = 0
        var didChange = PassthroughSubject<DataGet4, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func checkDeatils(year_ : String){
        var subText : String = ""
//        let body: [String: Any] = ["diaryDate" : year_]
//            let jsonData = try? JSONSerialization.data(withJSONObject: body)
        let url_ = URL(string: "http://52.78.241.137:8080/users/\(id_)/diary/content")!
        var urlComponents = URLComponents(url: url_, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "diaryDate", value: year_)
        ]
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        print(url)
            request.httpMethod = "GET"
//            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(shareToken, forHTTPHeaderField: "Authorization")
//            let bodyData = "diaryDate=\(year_)".data(using: .utf8)
//            request.httpBody = bodyData
            //request.httpBody = jsonData
//            print(id_)
            //print(year_)
//            print(body)
//            print(jsonData)
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }

                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                  let result = responseJSON["result"] as? [String: Any] {
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                        let jsonString = String(data: jsonData, encoding: .utf8)
                        print(jsonString)
                        self.v = jsonString ?? ""
                        print(self.v)
                        let chars = Array(self.v)
                        var cmd : Int = 0
                        var tmp : Int = 0
                        for char in chars {
                            cmd += 1
                            if(char == "["){
                                tmp = cmd
                                let startIndex = chars.index(chars.startIndex, offsetBy: cmd)
                                for i in startIndex..<chars.endIndex{
                                    tmp += 1
                                    if(chars[i] == "\""){
                                        let start = chars.index(chars.startIndex, offsetBy: tmp)
                                        for j in start..<chars.endIndex{
                                            if(chars[j] == "\""){
                                                break
                                            }
                                            subText.append(chars[j])
                                        }
                                        break
                                    }
                                }
                                break
                            }
                        }
                        self.sendText(send: subText)
                        let decodeData = try JSONDecoder().decode(String.self, from: jsonData)
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    func sendText(send : String){
        text = send
        print(text)
    }
}
class GetText : ObservableObject{
    @Published var TextValue : String = "\(text)"
    func prin() {
        print(self.TextValue)
    }
}

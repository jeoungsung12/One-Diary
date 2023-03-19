//
//  Kakao_Login_ViewApp.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/03.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct Kakao_Login_ViewApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate : MyAppDelegate
//    init() {
//        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
//            // Kakao SDK 초기화
//            KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
//        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

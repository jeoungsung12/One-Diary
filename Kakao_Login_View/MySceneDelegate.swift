//
//  SceneDelegate.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/03.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import UIKit

class MySceneDelegate : UIResponder, UIWindowSceneDelegate{
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
}

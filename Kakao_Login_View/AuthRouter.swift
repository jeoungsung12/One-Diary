//
//  AuthRouter.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/07.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKShare
////인증 라우터
////회원가입, 로그인, 토큰갱신
//enum AuthRouter: URLRequestConvertible {
//    case login(email: String, password: String)
//    case tokenRefresh
//    
//    var baseURL: URL{
//        return URL(string: KakaoAuthVM.BASE_URL)!
//    }
//    var endPoint: String{
//        switch self{
//        case .login:
//            return "user//login"
//        case .tokenRefresh:
//            return "user//token-refresh"
//        }
//    }
//    var method: HTTPMethod{
//        switch self{
//            //case .tokenRefresh: return get
//        default: return .post
//        }
//    }
//    var parameters: Parameters{
//        switch self{
//        case let .login(email, password):
//            var params = Parameters()
//            params["email"] = email
//            params["password"] = password
//            return params
//        case .tokenRefresh:
//            var params = Parameters()
//            //            params["refresh_token"] =
//            return params
//        }
//    }
//    func asURLRequest() throws -> URLRequest {
//        let url = baseURL.appendingPathComponent(endPoint)
//        var request = URLRequest(url: url)
//        request.method = method
//        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
//        return request
//    }
//}

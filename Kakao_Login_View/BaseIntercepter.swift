//
//  BaseIntercepter.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/07.
//

import Foundation
import Alamofire
class BaseInterCepter: RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        //헤더부분 넣어주기
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        completion(.success(request))
    }
}

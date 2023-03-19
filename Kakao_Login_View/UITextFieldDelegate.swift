//
//  TextDict.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/07.
//

import Foundation
import Combine

struct PostComment: Codable {
    let movieId: String
    let rating: Double
    let writer: String
    let contents: String

    enum CodingKeys: String, CodingKey {
        case rating, writer, contents
        case movieId = "movie_id"
    }
    func postComment(movieId: String, rating: Double, writer: String, contents: String) {

        // 넣는 순서도 순서대로
        let comment = PostComment(movieId: movieId, rating: rating, writer: writer, contents: contents)
        guard let uploadData = try? JSONEncoder().encode(comment)
        else {return}

        // URL 객체 정의
        let url = URL(string: "http://52.78.241.137:8080/users/1/diary/content")

        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // HTTP 메시지 헤더
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

            // 서버가 응답이 없거나 통신이 실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            print("comment post success")
        }
        // POST 전송
        task.resume()
    }
}

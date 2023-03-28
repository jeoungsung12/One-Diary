//
//  LottieView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import Foundation
import SwiftUI
import UIKit
import Lottie
//로티 애니메이션 뷰
struct LottieView2 : UIViewRepresentable{
    typealias UIViewType = UIView
    var filename: String
    func makeUIView(context: Context) -> UIView {
        //3.
                let view = UIView(frame: .zero)
                //4. Add animation
                let animationView = LottieAnimationView()
                //사용자 애니메이션 파일명
                animationView.animation = LottieAnimation.named(filename)
                //애니메이션 크기가 적절하게 조정될 수 있도록
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .playOnce
                //애니메이션 재생
//                animationView.play()
        
        animationView.play(fromProgress : 0, toProgress: 0.6)
                //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
                animationView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(animationView)
                
                //5. 자동완성 기능
                NSLayoutConstraint.activate([
                    //레이아웃의 높이와 넓이의 제약
                    animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                    animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
                ])
                
                
                return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
     //do nothing
    }
}

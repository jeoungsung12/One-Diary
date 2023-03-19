//
//  DiaryView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
import Combine

struct DiaryView: View {
    @State var story2 = Date()
    @State var story2_String : String = ""
    @State var year2 = Date()
    @State var year2_String : String = ""
    @State private var go_to_long: Bool = false
    @State private var go_to_Main: Bool = false
    @State var manager2 = DataPost2()
    var body: some View {
        NavigationView(){
            VStack{
                NavigationView(){
                    LottieView(filename: "tree")}.padding()
                Text("\t당신의 오늘 한 줄 일기")
                .foregroundColor(.gray)
                .font(.system(size:25))
                TextEditor(text: $story2_String)
                    .lineLimit(30)
                    .frame(width:350, height: 100)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.2)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                Text("\n\n\n\n\n\n\n\n\n\n\n")
                HStack{
                    Spacer()
                    NavigationLink(destination: MainView()
                        .navigationBarBackButtonHidden(true),
                                   isActive: $go_to_Main){
                        Button("작성"){
                            print("Clicked")
                            self.manager2.checkDeatils(story2: self.story2_String)
                            action : do {go_to_Main = true}
                        }
                        .disabled(story2_String.isEmpty)
                            .frame(width: 100, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }.disabled(story2_String.isEmpty)
                    Spacer()
                    NavigationLink(destination: LongTextView()
                        .navigationBarBackButtonHidden(true),
                                   isActive: $go_to_long){
                        Button("긴 글로 작성"){
                            //print("Clicked")
                            //                                self.manager2.checkDeatils(story2: self.story2_String)
                            action : do {go_to_long = true}
                        }
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
class DataPost2: ObservableObject{
        var didChange = PassthroughSubject<DataPost2, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func checkDeatils(story2 : String){
            let body: [String: Any] = ["data": ["story2" : story2]]
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            let url = URL(string: "http://52.78.241.137:8080/users/1/diary/content")!
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
                    print(responseJSON)
                }
            }
            task.resume()
        }
    }

    struct DiaryView_Previews: PreviewProvider {
        static var previews: some View {
            DiaryView()
        }
    }

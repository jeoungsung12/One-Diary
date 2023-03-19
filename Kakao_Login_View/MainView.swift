//
//  MainView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
import Combine
import Foundation
import Alamofire

struct MainView: View {
    
    @State var year1 = Date()
    @State var year1_String: String = ""
    @State var Value: String = ""
    @State var manager = DataPost4()
    var body: some View {
        NavigationView() {
            VStack{
                Text("\n")
                HStack{
                    Text("\t날짜 : \t")
                    TextField("YYYY-MM-DD", text: $year1_String);
                }
                Spacer()
                HStack{
                    Spacer()
                    Button("찾기") {
                        print("Clicked")
                        self.manager.checkDeatils(year: self.year1_String)
                    }.padding(.horizontal)
                           .frame(width: 100, height: 35)
                           .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                           .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                    Spacer()
                    NavigationLink(destination: TextView().navigationBarBackButtonHidden(true), label: {Text("새 일기 작성")}).padding(.horizontal)
                        .frame(width: 120, height: 35)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                 .padding(.bottom)
                    Spacer()
                }
                TextEditor(text: $Value)
              .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
              .frame(width: 350.0, height: /*@START_MENU_TOKEN@*/500.0/*@END_MENU_TOKEN@*/)
              .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.5)
                Spacer()
            }
        }
    }
}
class DataPost4: ObservableObject{
        var didChange = PassthroughSubject<DataPost4, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func checkDeatils(year : String){
        let body: [String: Any] = ["localDate" : year]
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

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

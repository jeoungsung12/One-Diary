//
//  LongTextView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
import Combine

struct LongTextView: View {
    @State var year_ = Date()
    @State var year = Date()
    @State var yearString: String = ""
    @State var story3 = Date()
    @State var story3_String : String = ""
    @State var sun = Date()
    @State var sunString: String = ""
    @State private var go_to_Main2: Bool = false
    @State var manager3 = DataPost3()
    var body: some View {
        NavigationView(){
            VStack{
                Text("")
                HStack{
                    DatePicker("  오늘 날짜 : ", selection: $year_, displayedComponents: .date)
                    Text(" ")
                }
                HStack{
                    Text("  날짜 :\t\t");
                    TextField("yyyy-mm-dd ", text: $yearString);
                    //                    Text("년");
                    //                    TextField("       00",
                    //                              text:  $monthString);
                    //                    Text("월");
                    //                    TextField("       00",
                    //                              text: $dayString);
                    //                    Text("일");
                }
                HStack{
                    Text("  날씨 :\t\t");
                    TextField("맑음", text: $sunString);
                }
                NavigationView(){
                    LottieView(filename: "tree")
                }
                Text("당신의 오늘 일기")
                .foregroundColor(.gray)
                .font(.system(size:25))
                TextEditor(text: $story3_String)
                    .lineLimit(100)
                    .frame(width:350, height: 390)
                    .font(.system(size:20))
                    .fontWeight(.bold)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.2)
                Text("")
                HStack{
                    NavigationLink(destination: MainView()
                        .navigationBarBackButtonHidden(true),
                                   isActive: $go_to_Main2){
                        Button("작성"){
                            print("Clicked")
                            self.manager3.checkDeatils(year: self.yearString, story3: self.story3_String, sun: self.sunString)
                            action : do {go_to_Main2 = true}
                        }.disabled(story3_String.isEmpty)
                            .frame(width: 100, height: 30)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.103, saturation: 0.235, brightness: 0.992, opacity: 0.781)/*@END_MENU_TOKEN@*/)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        }
                }
                Spacer()
            }
        }
    }
}
class DataPost3: ObservableObject{
        var didChange = PassthroughSubject<DataPost3, Never>()
        var formCompleted = false{
            didSet{
                didChange.send(self)
            }
        }
    func checkDeatils(year : String , story3 : String, sun : String){
        let body: [String: Any] = ["localDate" : year, "contents" : story3, "sun" : sun]
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

struct LongTextView_Previews: PreviewProvider {
    static var previews: some View {
        LongTextView()
    }
}

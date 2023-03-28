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
    @State var Long = Date()
    @State var yearString: String = ""
    @State var LongString: String = "L"
    @State var story3 = Date()
    @State var story3_String : String = ""
    @State var weather = Date()
    @State var weatherString: String = ""
    @State private var go_to_Main2: Bool = false
    @State private var go_to_menu: Bool = false
    @State var manager3 = DataPost3()
    var body: some View {
        NavigationView(){
            VStack{
                HStack{
                    Text(" ")
                NavigationLink(destination: MainView()
                    .navigationBarBackButtonHidden(true),
                               isActive: $go_to_menu){
                    Button("Main >>"){
                        //print("Clicked")
                        //                                self.manager2.checkDeatils(story2: self.story2_String)
                        action : do {go_to_menu = true}
                    }
                    .foregroundColor(.blue)
//                        .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
            }
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
//                HStack{
//                    Text("  날씨 :\t\t");
//                    TextField("맑음", text: $weatherString);
//                }
                NavigationView(){
                    LottieView(filename: "tree")
                }
                Text("당신의 오늘 일기")
                .foregroundColor(.gray)
                .font(.system(size:25))
                TextEditor(text: $story3_String)
                    .lineLimit(100)
                    .frame(width:310, height: 390)
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
                            self.manager3.checkDeatils(year: self.yearString, story3: self.story3_String, weather: self.weatherString, Long: self.LongString)
                            action : do {go_to_Main2 = true}
                        }.disabled(yearString.isEmpty || story3_String.isEmpty)
                            .frame(width: 100, height: 30)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
//                            .bold()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }.disabled(yearString.isEmpty || story3_String.isEmpty)
                }
                Spacer()
            }
        }
    }
}

struct LongTextView_Previews: PreviewProvider {
    static var previews: some View {
        LongTextView()
    }
}

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
    @State var year_ = Date()
    @State var year1_String: String = ""
    @State var Value: String = ""
    @State var ReValue: String = ""
    @State var TextRule: String = "yyyy-MM-dd"
    @State var manager4 = DataGet4()
    @State var manager = GetText()
    //@State var manager2 = DataPost3()
    var body: some View {
        NavigationView() {
            VStack{
                Text(" ")
                HStack{
                    Text("\t날짜 : \t")
                    TextField("\(TextRule)", text: $year1_String);
                }
                Spacer()
                Text("\n")
                HStack{
                    Spacer()
                    Button("찾기") {
                        self.manager4.checkDeatils(year_: self.year1_String)
                    }.padding(.horizontal)
                           .frame(width: 100, height: 35)
                           .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                           .foregroundColor(.white)
//                           .bold()
                           .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)
                    Spacer()
                    Button("수정") {
                        //ReValue = manager4.v
//                        self.manager2.checkDeatils(year: self.year1_String, story3: self.ReValue, weather: self.weather_String, Long: "L")
                    }.padding(.horizontal)
                           .frame(width: 100, height: 35)
                           .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                           .foregroundColor(.white)
//                           .bold()
                           .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom)
                    Spacer()
                }
//                NavigationView(){
//                     LottieView3(filename: "message")
//                }
                Text("")
                TextEditor(text: $manager.TextValue)
              .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
              .frame(width: 310, height: 500)
              .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.5)
               Spacer()
                Text("")
                HStack{
                    Spacer()
                    NavigationLink(destination: TextView().navigationBarBackButtonHidden(true), label: {Text("새 일기 작성")}).padding(.horizontal)
                        .frame(width: 120, height: 35)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .bold()
                 .padding(.bottom)
                 Text("\t")
                }
            }
        }
    }
}


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

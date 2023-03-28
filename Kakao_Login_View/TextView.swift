//
//  TextView.swift
//  Kakao_Login_View
//
//  Created by 정성윤 on 2023/03/04.
//

import SwiftUI
import Combine

struct TextView: View {
    //    @StateObject var textdict : UITextFieldDelegate = UITextFieldDelegate()
//    @Binding var year2 : String
//    @Binding var year3 : String
    @State var shortString : String = "S"
    @State var year = Date()
    @State var short = Date()
    @State var year_ = Date()
    @State var yearString: String = ""
    //    @State var month = Date()
    //    @State var monthString: String = ""
    //    @State var day = Date()
    //    @State var dayString: String = ""
    @State var feel = Date()
    @State var feelString: String = ""
    //    @State var story = Date()
    //    @State var storyString: String = ""
    @State var weather = Date()
    @State var weatherString: String = ""
    @State private var go: Bool = false
    @State private var go_to_long: Bool = false
    @State private var go_to_menu: Bool = false
    @State var manager = DataPost_()
    var body: some View {
        NavigationView(){
            VStack{
                HStack{
//                    Text("")
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
                    DatePicker("오늘 날짜 : ", selection: $year_, displayedComponents: .date)
                HStack{
                    Text("날짜 :\t\t");
                    TextField("yyyy-mm-dd ", text: $yearString);
                    //                    Text("년");
                    //                    TextField("       00",
                    //                              text:  $monthString);
                    //                    Text("월");
                    //                    TextField("       00",
                    //                              text: $dayString);
                    //                    Text("일");
                }
                
                    VStack{
                        NavigationView(){
                            LottieView(filename: "feeling")
                        }
                    }
                    Text("당신의 오늘 한 줄 일기")
                    .foregroundColor(.gray)
                    .font(.system(size:25))
                    TextEditor(text: $feelString)
                    .lineLimit(30)
                    .frame(width:310, height: 100)
                    .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.2)
                        .font(.system(size:20))
                        .fontWeight(.bold)
                    Text("\n\n\n\n\n\n\n\n\n\n\n\n\n")
                HStack{
                    Spacer()
                    NavigationLink(destination: MainView()
                        .navigationBarBackButtonHidden(true), isActive: $go) {
                            Button("작성"){
                                //                        let dateFormatter = DateFormatter()
                                //                        dateFormatter.dateStyle = . short
                                //                        year2 = dateFormatter.string(from: year)
                                //                        year = dateFormatter.string(from: year)
                                //                    monthString = dateFormatter.string(from: month)
                                //                    dayString = dateFormatter.string(from: day)
                                //                    feelString = dateFormatter.string(from: feel)
                                ////                    storyString = dateFormatter.string(from: story)
                                //                    sunString = dateFormatter.string(from: sun)
                                
                                print("Clicked")
                                self.manager.checkDeatils(year: self.yearString, feel: self.feelString, weather: self.weatherString, short: self.shortString)
                                action : do {go = true}
                            }.disabled(yearString.isEmpty || feelString.isEmpty)
                                .frame(width: 100, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
//                                .bold()
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }.disabled(yearString.isEmpty || feelString.isEmpty)
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
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
//                        .bold()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                }
            }.padding()
        }
    }
}
  
struct TextView_Previews: PreviewProvider {
        static var previews: some View {
            TextView()
        }
    }

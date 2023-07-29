//
//  ContentView.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/28.
//

import SwiftUI

extension Color{
    static let coutomAccentColor = Color("Accent")
}

//最初のView
struct ContentView: View {
    @State private var activie = false
    @State private var backgroundColor = UIColor.white
    var body: some View {
        NavigationStack{ //NavigationViewばつ
            ZStack{
                Color(backgroundColor)
                    .ignoresSafeArea()
                VStack{
                    Text("FirstPage")
                    Button { //ボタン
                        activie.toggle() //ボタン押下で実行したい処理記述
                        //backgroundColor = .cyan //遷移したのち前の画面をシアンにする
                    } label: { //TextやImageでボタンの表示作成
                        HStack{
                            Image(systemName: "arrowshape.right.fill")
                            Text("NextPage")
                        }
                }

            }
            }.buttonStyle(.bordered)
                .navigationDestination(isPresented: $activie, destination: {
                    ViewArrangement() //遷移先画面
                })
        }
    }
}
////遷移先のView
//struct nextView: View {
//    var body: some View {
//        NavigationView {
//            ZStack{
//                Color.black
//                    .ignoresSafeArea()
//                Text("SecondView")
//                    .foregroundColor(.white)
//            }
//        }
//    }
//}

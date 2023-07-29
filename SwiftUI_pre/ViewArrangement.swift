//
//  ViewArrangement.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/28.
//

import SwiftUI

extension UINavigationController {
    
    func clearBackgroundColor() {
        topViewController?.view.backgroundColor = .clear
        topViewController?.parent?.view.backgroundColor = .clear
        topViewController?.parent?.parent?.view.backgroundColor = .clear
    }
}

struct ViewArrangement: View {
    @State private var activie = false
    @State private var active = false
    // @Environment(\.dismiss) var dismiss
    //@State var selectedTab = 1
    @State private var isPresented: Bool = false
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        
        //上のタブバーあたりのコード
        NavigationView{
            ZStack{
                Color.white //背景の色
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        // TODO: げんどを決めなければいけない？？それとも無限？？？
                        ForEach(0..<100) { index in
                            VStack {
                                Image("image0") // 画像を表示
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 100)
                                    .cornerRadius(10) //角まる
                                
                                Text("Item \(index + 1)") // テキストを表示
                                    .foregroundColor(.black)
                                    .font(.headline)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 100) // Rectangle()と同じ高さの余白を追加
                }
                
                VStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 820, height: 130)
                    //.position(x: 0, y: 0)
                        .edgesIgnoringSafeArea(.top) // SafeAreaを無視して表示
                        .overlay(
                            HStack {
                                Image("icon")
                                    .resizable()
                                    .scaledToFit()      //縦横比を維持しながらフレームに収める
                                    .frame(width: 31, height: 31)
                                    .position(x: 570, y: 12)
                                //ナビゲーター
                                Text("さがす")
                                    .position(x: -60, y: 46)
                                    .foregroundColor(.coutomAccentColor)
                                Spacer()
                            }
                        )
                    
                    Spacer()
                    NavigationLink(destination: PostView(), isActive: $active) {
                        HStack {
                            Text("みっけ")
                                .foregroundColor(.gray)
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .buttonStyle(TransparentButtonStyle())
                    }
                    .position(x: 480, y: -92)
                }
                .navigationTitle("") // Clear navigation title
                .navigationBarHidden(true) // Hide the navigation bar
            }
        }
    }
}

struct TransparentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}





struct ViewArrangement_Previews: PreviewProvider {
    static var previews: some View {
        ViewArrangement()
    }
}


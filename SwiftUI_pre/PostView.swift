//
//  PostView.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/29.
//

import SwiftUI
import UIKit


//@State private var selectedImage: UIImage?
struct PostView: View {
    //@State private var bodyView: CGSize = .zero // 17行目で使用する変数を@Stateで定義
    //@State private var selectedImage: UIImage?
    @State private var isImageDetailViewActive = false

    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("投稿する")
                    .font(
                        Font.custom("Inria Sans", size: 14)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(0..<12) { index in
                            //                            NavigationLink(destination:ImageDetailView(imageName: "image\(index)")){
                            //                                EmptyView() // ラベルを空にする
                            //                                Image("image\(index)") // 画像を表示
                            //                                    .resizable()
                            //                                    .scaledToFit()
                            //                                //.clipShape(RoundedRectangle(cornerRadius: 10))
                            //                                //.padding(.vertical, 8)
                            //                            }
                            Button(action: {
                                isImageDetailViewActive = true // ボタンがタップされたらImageDetailViewに遷移
                            }) {
                                Image("image\(index)") // 画像を表示
                                    .resizable()
                                    .scaledToFit()
                            }
                            .sheet(isPresented: $isImageDetailViewActive) {
                                ImageDetailView(imageName: "image\(index)")
                            }
                        }
                        //.navigationBarBackButtonHidden(true) // 戻るボタンを非表示にする
                        //.buttonStyle(PlainButtonStyle()) // デフォルトのスタイルを適用
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


struct ImageDetailView: View {
    @State private var isPresented: Bool = false
    var imageName: String // 遷移時に受け取る画像名
    
    var body: some View {
        VStack {
            Image(imageName) // 遷移時に受け取った画像名で画像を表示
                .resizable()
                .aspectRatio(contentMode: .fit)
            //.navigationBarTitle(imageName) // ナビゲーションバーのタイトルを画像名に設定
                .position(x:195,y:300)
            Button(action: {
                // ボタンがタップされた時のアクションを実装
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    isPresented = true
                }
            }) {
                Text("投稿 > ") // ボタンのテキストラベル
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 42)
                    .background(Color(red: 0.98, green: 0.74, blue: 0.12))
                    .cornerRadius(21)
                
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            ViewArrangement()
        }
    }
}
    
    
    
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

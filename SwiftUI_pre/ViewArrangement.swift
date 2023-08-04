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
    //@State private var activie = false
    @State private var active = false
    // @Environment(\.dismiss) var dismiss
    //@State var selectedTab = 1
    //@State private var isPresented: Bool = false
    //@State private var bodyView: CGSize = .zero
    // @State private var isImageDetailViewActive = false
    @ObservedObject var semiAPI = SemiService()
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var body: some View {
        
        //上のタブバーあたりのコード
        NavigationView{
            ZStack{
                Color.white //背景の色
                VStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 820, height: 130)
                    //.position(x: 0, y: 0)
                        .edgesIgnoringSafeArea(.top) // SafeAreaを無視して表示
                        .overlay(
                            HStack {
                                Image("icon1")
                                    .resizable()
                                    .scaledToFit()      //縦横比を維持しながらフレームに収める
                                    .frame(width: 31, height: 31)
                                    .position(x: 570, y: 12)
                                //ナビゲーター
                                Text("さがす")
                                    .position(x: -60, y: 46)
                                    .foregroundColor(Color.coutomAccentColor)
                                Spacer()
                            }
                        )
                    
                    Spacer()
                    NavigationLink(destination: Cameraview(), isActive: $active) {
                        HStack {
                            Text("みっけ")
                                .foregroundColor(.gray)
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .buttonStyle(TransparentButtonStyle())
                    }
                    // TODO: 色変わってない.戻る矢印のやつ．デフォルトの青のまま
                    .accentColor(Color.coutomAccentColor)
                    .position(x: 480, y: -92)
                    
                }
                .navigationTitle("") // Clear navigation title
                .navigationBarHidden(true) // Hide the navigation bar
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        // TODO: 限度を決めなければいけない？？それとも無限？？
                        // TODO: それぞれの配置，一つずつの
                        if self.semiAPI.posts != nil{
                            ForEach(self.semiAPI.posts!, id: \.id){post in
                                //
                                //                            }
                                //                        }
                                VStack {
                                    HStack {
                                        Rectangle() //icon
                                            .foregroundColor(.clear)
                                            .frame(width: 31, height: 31)
                                            .background(
                                                Image("icon0")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 31, height: 31)
                                                    .clipped()
                                            )
                                            .cornerRadius(31)
                                            .offset(x: -65, y: 4)
                                        Text(post.user_name) //名前
                                            .font(
                                                Font.custom("Inria Sans", size: 14)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.black)
                                            .offset(x: -63, y: 4)
                                        Text("東京都") //場所
                                            .font(
                                                Font.custom("Inria Sans", size: 10)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.black)
                                            .offset(x: 65, y: 12)
                                        Text(post.updated_at) //日付
                                            .font(
                                                Font.custom("Inria Sans", size: 10)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.black)
                                            .offset(x: 65, y: 12)
                                        //                                        Text("12:05") //時刻
                                        //                                            .font(
                                        //                                                Font.custom("Inria Sans", size: 9)
                                        //                                                    .weight(.bold)
                                        //                                            )
                                        //                                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                        //                                            .offset(x: 65, y: 12)
                                    }
                                    
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 390, height: 200)
                                        .background(
                                            
                                            AsyncImage(url: URL(string: post.img)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                                .frame(width: 240, height: 126))
                                    //.resizable()
                                    //.aspectRatio(contentMode: .fill)
                                        .clipped()
                                    if(post.semi == false){
                                        Text("せみのぬけがらではありません")
                                            .font(
                                                Font.custom("Inria Sans", size: 15)
                                                    .weight(.bold)
                                            )
                                            .foregroundColor(.red)
                                            .offset(x: 65, y: -10)
                                    }
                                }
                                
                                
                                
                                
                                ZStack {
                                    // TODO: 多分ここ，ボタンだよね...いいねの数
                                    Rectangle()
                                    //Button("goodbotton")
                                        .foregroundColor(.clear)
                                    
                                        .frame(width: 54, height: 23)
                                        .background(.white)
                                        .cornerRadius(11.5)
                                        .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 2)
                                        .position(x: 540, y: 12)
                                    Image("good")
                                        .frame(width: 11, height: 12)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color(red: 0.19, green: 0.16, blue: 0.16), lineWidth: 0)
                                        )
                                        .position(x: 530, y: 12)
                                    Text("15") //goodnumber
                                        .font(
                                            Font.custom("Inria Sans", size: 10)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                        .frame(width: 12, height: 15, alignment: .topLeading)
                                        .position(x: 552, y: 14)
                                }
                            }
                        }
                    }
                }
                .onAppear{semiAPI.fetchPosts()}
                .padding(.horizontal)
                .padding(.top, 100) // Rectangle()と同じ高さの余白を追加
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


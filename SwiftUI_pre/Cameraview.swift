//
//  Cameraview.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/30.
//

import SwiftUI
//extension Color{
//    static let coutomAccentColor = Color("Accent")
//}

struct Cameraview: View {
    @State var imageData : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    @State var userName: String = ""
    @ObservedObject var semiAPI = SemiService()
    @State private var isPresented: Bool = false
    
    @State var isActionSheet = false
    @State var isImagePicker = true
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                ZStack{
                    NavigationLink(
                        destination: Imagepicker(show: $isImagePicker, image: $imageData, sourceType: source),
                        isActive:$isImagePicker,
                        label: {
                            Text("")
                        })
                    VStack{
                        if imageData.count != 0{
                            Image(uiImage: UIImage(data: self.imageData)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                                .cornerRadius(15)
                                .padding()
                        }
                        HStack(spacing:30){
                            Button(action: {
                                self.source = .photoLibrary
                                self.isImagePicker.toggle()
                            }, label: {
                                Text("アルバム")
                            })
                            //                            Button(action: {
                            //                                self.source = .camera
                            //                                self.isImagePicker.toggle()
                            //                            }, label: {
                            //                                Text("カメラ")
                            //                            })
                        }
                        
                        TextField("投稿者名", text: $userName).padding()
                        Button(action: {
                            semiAPI.pushImage(user_name:userName, img: self.imageData)
                            // ボタンがタップされた時のアクションを実装
                            var transaction = Transaction()
                            transaction.disablesAnimations = true
                            withTransaction(transaction) {
                                isPresented = true
                            }
                        } ){
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
        }
        .navigationBarTitle("投稿する", displayMode: .inline)
        
    }
    //        .onAppear{(self.source = .photoLibrary
    //                   ,self.isImagePicker.toggle())}
    //.ignoresSafeArea(.all, edges: .top)
       // .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    
}


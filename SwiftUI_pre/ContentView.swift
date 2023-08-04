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

struct CameraView: View {
    
    @State var imageData : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    @State var userName: String = ""
    @ObservedObject var semiAPI = SemiService()
    
    @State var isActionSheet = false
    @State var isImagePicker = false
    
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
//                                    Button(action: {
//                                        self.source = .camera
//                                        self.isImagePicker.toggle()
//                                    }, label: {
//                                        Text("カメラ")
//                                    })
                                }
                                
                                TextField("投稿者名", text: $userName).padding()
                                Button("投稿"){
                                    semiAPI.pushImage(user_name:userName, img: self.imageData)
                                }
                                
                            }
                        }
                }
                .navigationBarTitle("Home", displayMode: .inline)
            }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

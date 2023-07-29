//
//  ImageSellectionView.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/30.
//

import SwiftUI
import UIKit

struct ImageSellectionView: View {
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("画像が選択されていません")
            }
            
            Button("画像を選択") {
                // UIImagePickerControllerを表示
                ImagePicker(image: $selectedImage, sourceType: .photoLibrary)
            }
        }
        .padding()
    }
}

struct ImageSellectionView: PreviewProvider {
    static var previews: some View {
        ImageSellectionView()
    }
}

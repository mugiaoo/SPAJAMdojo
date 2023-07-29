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
    @State private var bodyView: CGSize = .zero // 17行目で使用する変数を@Stateで定義

    var body: some View {
        VStack(spacing: 0) {
            Text("Image")
                .frame(width: bodyView.width, alignment: .center)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom)
            if let imagePath = Bundle.main.path(forResource: "image0", ofType: "png") {
                Image(path: imagePath)
            } else {
                Text("画像が見つかりません")
            }
        }
    }
}

extension Image {
    init(path: String) {
        self.init(uiImage: UIImage(named: path)!)
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

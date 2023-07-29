//
//  PostView.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/29.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            Text("SecondView")
                .foregroundColor(.white)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

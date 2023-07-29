//
//  LaunchScreen.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/29.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isLoading = true
    @State private var backgroundColor = UIColor.white

        var body: some View {
            if isLoading {
                ZStack {
                    Color(backgroundColor)
                        .ignoresSafeArea() // ステータスバーまで塗り潰すために必要
                    Image("icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            isLoading = false
                        }
                    }
                }
            } else {
                ViewArrangement()
            }
        }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}

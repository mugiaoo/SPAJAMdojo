//
//  ViewArrangement.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/28.
//

import SwiftUI

struct ViewArrangement: View {
    var body: some View {
        ZStack{
            AlignmentPanel(text: ".topLeading¥n(左上寄せ)", alignment: .topLeading)
            AlignmentPanel(text: ".top¥n(上寄せ)", alignment: .top)
            AlignmentPanel(text: ".topTrailing¥n(右上寄せ)", alignment: .topTrailing)
            AlignmentPanel(text: ".Leading¥n(左寄せ)", alignment: .leading)
            AlignmentPanel(text: ".center¥n(中央寄せ)", alignment: .center)
            AlignmentPanel(text: ".Trailing¥n(右寄せ)", alignment: .trailing)
            AlignmentPanel(text: ".boyyomLeading¥n(左下寄せ)", alignment: .bottomLeading)
            AlignmentPanel(text: ".bottom¥n(下寄せ)", alignment: .bottom)
            AlignmentPanel(text: ".bottomTrailing¥n(右下寄せ)", alignment: .bottomTrailing)
        }
    }
}

struct AlignmentPanel: View{
    let text: String
    let alignment: Alignment //arignment=位置合わせ
    
    var body: some View{
        let words = text.components(separatedBy: "¥n")
        VStack{
            //行ごとにセンタリング表示するため，個別のTextViewにする
            ForEach(0..<words.count, id: \.self){ index in
                Text(words[index])
            }
        }
        .frame(width: 125, height: 98) //大きさ
        .background(Color.yellow)
        .frame(width: 400
               , height: 320, alignment: alignment) //位置　中央寄せの真ん中の位置？が0,0
    }
}

struct ViewArrangement_Previews: PreviewProvider {
    static var previews: some View {
        ViewArrangement()
    }
}

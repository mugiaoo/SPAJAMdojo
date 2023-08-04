//
//  SemiService.swift
//  SwiftUI_pre
//
//  Created by Mugi on 2023/07/30.
//

import Foundation

struct ResponsePost: Codable {
    var id: Int
    var img: String
    var semi: Bool
    var user_name: String
    var created_at: String
    var updated_at: String
}

struct ResponseImg: Codable {
    var img: String
}

struct RequestPost: Codable {
    var img: String
    var user_name: String
}

class SemiService : ObservableObject{
    
    @Published var posts: [ResponsePost]?

    init() {
        self.posts = []
        self.fetchPosts()
    }
    
    
    let boundary = "----WebKitFormBoundaryZLdHZy8HNaBmUX0d"
     
    func httpBody(_ fileAsData: Data) -> Data {
        var data = "--\(boundary)\r\n".data(using: .utf8)!
        // サーバ側が想定しているinput(type=file)タグのname属性値とファイル名をContent-Dispositionヘッダで設定
        data += "Content-Disposition: form-data; name=\"file\"; filename=\"semi.png\"\r\n".data(using: .utf8)!
        data += "Content-Type: image/png\r\n".data(using: .utf8)!
        data += "\r\n".data(using: .utf8)!
        data += fileAsData
        data += "\r\n".data(using: .utf8)!
        data += "--\(boundary)--\r\n".data(using: .utf8)!
         
        return data
    }
    //TODO: [POST] /semi/img
    func pushImage(user_name:String, img:Data) {
        
        let data = httpBody(img)
        let push_img_url = URL(string:"https://tk2-244-31983.vs.sakura.ne.jp/semi/img")!
        var request = URLRequest(url: push_img_url)
        request.httpMethod = "POST"
        
        // マルチパートでファイルアップロード
        let headers = ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        let urlConfig = URLSessionConfiguration.default
        urlConfig.httpAdditionalHeaders = headers
        let session = Foundation.URLSession(configuration: urlConfig)
        let task = session.uploadTask(with: request, from: data){ (data, response, error) in
            guard let data = data else { return }
            do {
                /// ②JSON→Responseオブジェクト変換
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(ResponseImg.self, from: data) else {
                    print("Json decode エラー")
                    return
                }
                self.pushPost( user_name: user_name, img_url: "https://tk2-244-31983.vs.sakura.ne.jp/imgs/\(decodedResponse.img)" )
            }
        }
        task.resume()
    }
    
    //[POST] /semi/post
    func pushPost(user_name:String, img_url:String) {
        //TODO: [POST] /semi/img
        let push_img_url = URL(string:"https://tk2-244-31983.vs.sakura.ne.jp/semi/img")!
        
        //TODO: [POST] /semi/post
        let push_post_url = URL(string:"https://tk2-244-31983.vs.sakura.ne.jp/semi/post")!
        let req_data: [String: Any] = ["user_name": user_name, "img_url": img_url]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: req_data, options: []) else {return}
        var request = URLRequest(url: push_post_url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            do {
                /// ②JSON→Responseオブジェクト変換
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode([ResponsePost].self, from: data) else {
                    print("Json decode エラー")
                    return
                }
                /// ③書籍情報をUIに適用
                DispatchQueue.main.async {
                    self.posts = decodedResponse
                }
            }
        }
        task.resume()
    }

    //[GET] /semi/posts
    func fetchPosts() {
        print("fetch posts")
        let url = URL(string:"https://tk2-244-31983.vs.sakura.ne.jp/semi/posts")!
        let request = URLRequest(url: url)               //Requestを生成
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                /// ②JSON→Responseオブジェクト変換
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode([ResponsePost].self, from: data) else {
                    print("Json decode エラー")
                    return
                }
                /// ③書籍情報をUIに適用
                DispatchQueue.main.async {
                    self.posts = decodedResponse
                }
            }
        }
        task.resume()
//        dump(self.posts)
    }
}


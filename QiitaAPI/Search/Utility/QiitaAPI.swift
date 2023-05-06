//
//  QiitaAPI.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import Foundation
enum QiitaError: Error {
    case error
}
final class QiitaAPI {
    static let shared = QiitaAPI()
    private init() {}
    func get (searchTextField: String ,completion: ((Result<[QiitaModel], QiitaError>) -> Void)? = nil) {
        guard searchTextField.count > 0 else {
            completion?(.failure(.error))
            return
        }
        print(searchTextField)
        if let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20&query=qiita+title%3A\(searchTextField)") {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error ) in
                let jsonDecoder = JSONDecoder()
                guard let data = data,
                      
                      let decoded = try? jsonDecoder.decode([QiitaModel].self, from: data) else {
                    completion?(.failure(.error))
                    return
                }
                completion?(.success(decoded))
            }
            task.resume()
        }
    }
}

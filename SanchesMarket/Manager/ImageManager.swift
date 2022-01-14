//
//  ImageManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import UIKit

struct ImageManager {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchImage(url: String,
                    completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            let result = session.obtaionResponseData(data: data, response: response, error: error)
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                guard let imageData = UIImage(data: data) else {
                    completionHandler(.failure(.convertImageFailed))
                    return
                }
                completionHandler(.success(imageData))
            }
        }.resume()
    }
}

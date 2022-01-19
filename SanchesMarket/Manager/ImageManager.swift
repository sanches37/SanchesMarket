//
//  ImageManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import UIKit

struct ImageManager {
    private let cache = URLCache.shared
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func fetchImage(url: String,
                    completionHandler: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidURL))
            return nil
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        if let response = cache.cachedResponse(for: request),
           let imageData = UIImage(data: response.data) {
            completionHandler(.success(imageData))
            return nil
        } else {
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let convertResponse = response, let convertData = data {
                    self.cache.storeCachedResponse(CachedURLResponse(response: convertResponse, data: convertData), for: request)
                }
                let result = session.obtaionResponseData(data: data, response: response, error: error)
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                    return
                case .success(let data):
                    guard let imageData = UIImage(data: data) else {
                        completionHandler(.failure(.convertImageFailed))
                        return
                    }
                    completionHandler(.success(imageData))
                }
            }
            dataTask.resume()
            return dataTask
        }
    }
}

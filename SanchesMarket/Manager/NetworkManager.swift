//
//  NetworkManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

struct NetworkManager {
    private let request = Request()
    private let rangeOfSuccessState = 200...299
    
    func commuteWithAPI(api: Requestable,
                        completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let request = try? request.createRequest(api: api) else {
            completionHandler(.failure(.requestFailed))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(.unknown(description: error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.responseFailed))
                return
            }
            guard rangeOfSuccessState.contains(response.statusCode) else {
                completionHandler(.failure(.outOfRange(statusCode: response.statusCode)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.dataNotfound))
                return
            }
            completionHandler(.success(data))
        }
        .resume()
    }
}


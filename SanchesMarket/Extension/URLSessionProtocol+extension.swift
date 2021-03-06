//
//  URLSessionProtocol+extension.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import Foundation

extension URLSessionProtocol {
    func obtaionResponseData(data: Data?,
                             response: URLResponse?,
                             error: Error?) -> Result<Data, NetworkError> {
        let rangeOfSuccessState = 200...299
        if let error = error {
            return .failure(.unknown(description: error.localizedDescription))
        }
        guard let response = response as? HTTPURLResponse else {
            return .failure(.responseFailed)
        }
        guard rangeOfSuccessState.contains(response.statusCode) else {
            return .failure(.outOfRange(statusCode: response.statusCode))
        }
        guard let data = data else {
            return .failure(.dataNotfound)
        }
        return .success(data)
    }
}

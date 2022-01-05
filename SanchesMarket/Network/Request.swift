//
//  Request.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

struct Request {
    private func createRequest(api: Requestable) throws -> URLRequest {
        guard let url = URL(string: api.url.path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = api.httpMethod.value
        request.setValue(api.contentType.format,
                         forHTTPHeaderField: ContentType.httpHeaderField)
        
        if let api = api as? DeleteApi {
            guard let body = try? JSONEncoder().encode(api.password) else {
                throw ParsingError.encodingFailed
            }
            request.httpBody = body
        }
        return request
    }
}

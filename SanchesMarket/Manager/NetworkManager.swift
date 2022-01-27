//
//  NetworkManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

struct NetworkManager {
    private let request = Request()
    private let session: URLSessionProtocol
    private var applicableHTTPMethod: [APIHTTPMethod]
    
    init(session: URLSessionProtocol = URLSession.shared, applicableHTTPMethod: [APIHTTPMethod] = APIHTTPMethod.allCases) {
        self.session = session
        self.applicableHTTPMethod = applicableHTTPMethod
    }
    
    func commuteWithAPI(api: Requestable,
                        completionHandler: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let request = try? request.createRequest(api: api) else {
            completionHandler(.failure(.requestFailed))
            return
        }
        guard applicableHTTPMethod.contains(api.httpMethod) else {
            completionHandler(.failure(.invalidHttpMethod))
            return
        }
        session.dataTask(with: request) { data, response, error in
            let result = session.obtaionResponseData(
                data: data, response: response, error: error)
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                completionHandler(.success(data))
            }
        }
        .resume()
    }
}


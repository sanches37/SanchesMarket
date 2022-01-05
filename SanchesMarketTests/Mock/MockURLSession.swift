//
//  MockURLSession.swift
//  SanchesMarketTests
//
//  Created by tae hoon park on 2022/01/06.
//

import Foundation
@testable import SanchesMarket

class MockURLSession: URLSessionProtocol {
    let parsingManager = ParsingManager()
    var url = URL(string: APIURL.getItem(id: 1).path)!
    
    let sessionDataTask = MockURLSessionDataTask()
    var isRequestSucess: Bool
    
    init(isRequestSucess: Bool) {
        self.isRequestSucess = isRequestSucess
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil)
        let failureResponse = HTTPURLResponse(url: url, statusCode: 402, httpVersion: "2", headerFields: nil)
        
        if isRequestSucess {
            let sampleData = try? parsingManager.loadedDataAsset(assetName: "Item").data
            sessionDataTask.resumeDidCall = { completionHandler(sampleData, successResponse, nil)}
        } else {
            sessionDataTask.resumeDidCall = { completionHandler(nil, failureResponse, nil)}
        }
        return sessionDataTask
    }
}

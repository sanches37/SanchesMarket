//
//  NetworkProtocol.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/06.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

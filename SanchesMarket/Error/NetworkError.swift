//
//  NetworkError.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case unknown(description: String)
    case responseFailed
    case outOfRange(statusCode: Int)
    case dataNotfound
}

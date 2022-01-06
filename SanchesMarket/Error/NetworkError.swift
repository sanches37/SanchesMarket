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
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .requestFailed:
            return "리퀘스트를 받는데 실패했습니다."
        case .unknown(let description):
            return "에러: \(description)"
        case .responseFailed:
            return "리스폰스를 받는데 실패했습니다."
        case .outOfRange(let statusCode):
            return "상태코드: \(statusCode)"
        case .dataNotfound:
            return "데이터를 전달 받지 못했습니다."
        }
    }
}

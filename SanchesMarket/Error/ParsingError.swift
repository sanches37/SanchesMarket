//
//  ParsingError.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

enum ParsingError: Error, LocalizedError {
    case loadAssetFailed
    case decodingFailed
    case encodingFailed
    
    var errorDescription: String {
        switch self {
        case .loadAssetFailed:
            return "에셋 데이터를 불러오는데 실패했습니다."
        case .decodingFailed:
            return "디코딩에 실패했습니다."
        case .encodingFailed:
            return "인코딩에 실패했습니다."
        }
    }
}

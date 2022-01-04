//
//  ParsingManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import UIKit

enum ParsingError: Error, LocalizedError {
    case assetFailed
    case decodingFailed
    
    var errorDescription: String {
        switch self {
        case .assetFailed:
            return "에셋 데이터를 불러오는데 실패했습니다."
        case .decodingFailed:
            return "디코딩에 실패했습니다."
        }
    }
}

struct ParsinManager {
    private let jsonDecoder = JSONDecoder()
    
    func receivedDataAsset(assetName: String) throws -> NSDataAsset {
        guard let dataAsset = NSDataAsset(name: assetName) else {
            throw ParsingError.assetFailed
        }
        return dataAsset
    }
    
    func decodedJsonData<T: Decodable>(type: T.Type, data: Data) throws -> T {
        guard let decodedData = try? jsonDecoder.decode(type, from: data) else {
            throw ParsingError.decodingFailed
        }
        return decodedData
    }
}

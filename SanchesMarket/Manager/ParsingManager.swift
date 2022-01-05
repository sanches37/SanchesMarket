//
//  ParsingManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import UIKit

struct ParsingManager {
    private let jsonDecoder = JSONDecoder()
    
    func loadedDataAsset(assetName: String) throws -> NSDataAsset {
        guard let dataAsset = NSDataAsset(name: assetName) else {
            throw ParsingError.loadAssetFailed
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

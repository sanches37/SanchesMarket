//
//  SanchesMarketTests.swift
//  SanchesMarketTests
//
//  Created by tae hoon park on 2022/01/04.
//

import XCTest
@testable import SanchesMarket

class SanchesMarketTests: XCTestCase {
    var parsingManager: ParsingManager?
    
    override func setUp() {
        super.setUp()
        parsingManager = ParsingManager()
    }
    
    func test_Items_에셋파일을_ProductCollection_타입으로_디코딩에_성공하면_title은_MacBookPro다() {
        // given
        let expectInputValue = "Items"
        // when
        guard let jsonData = try? parsingManager?.loadedDataAsset(assetName: expectInputValue),
              let decodedData = try? parsingManager?.decodedJsonData(type: ProductCollection.self, data: jsonData.data) else {
                  return XCTFail()
              }
        let expectResult = "MacBook Pro"
        let result = decodedData.items.first?.title
        // then
        XCTAssertEqual(expectResult, result)
    }
    
    func test_Item_에셋파일을_Product_타입으로_디코딩에_성공하면_price는_1690000이다() {
        // given
        let expectInputValue = "Item"
        // when
        guard let jsonData = try? parsingManager?.loadedDataAsset(assetName: expectInputValue),
              let decodedData = try? parsingManager?.decodedJsonData(type: Product.self, data: jsonData.data) else {
                  return XCTFail()
              }
        let expectResult = 1690000
        let result = decodedData.price
        // then
        XCTAssertEqual(expectResult, result)
    }
}

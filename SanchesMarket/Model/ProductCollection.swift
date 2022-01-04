//
//  ItemsData.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import Foundation

struct ProductCollection: Codable {
    let page: Int
    let items: [Product]
}

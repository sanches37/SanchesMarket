//
//  ItemsData.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import Foundation

struct ItemsDate: Codable {
    let page: Int
    let items: [ItemsDate]
}

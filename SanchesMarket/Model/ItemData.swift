//
//  ItemData.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import Foundation

struct ItemData: Codable {
    let id: String
    let title: String
    let descriptions: String?
    let price: Int
    let currency: String
    let stock: Int
    let discountedPrice: Int?
    let thumbnails: [String]
    let images: [String]?
    let registrationDate: String
    
    enum Codingkeys: String, CodingKey {
        case id, title, descriptions, price, currency, stock, thumbnails, images
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}

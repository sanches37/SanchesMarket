//
//  parameter.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

struct MultipartFormData {
    var title: String?
    var descriptions: String?
    var price: Int?
    var currency: String?
    var stock: Int?
    var discountedPrice: Int?
    var password: String?
    
    var parameter: [String: Any] {
        var param: [String: Any] = [:]
        
        if let title = self.title {
            param["title"] = title
        }
        if let descriptions = self.descriptions {
            param["descriptions"] = descriptions
        }
        if let price = self.price {
            param["price"] = price
        }
        if let currency = self.currency {
            param["currency"] = currency
        }
        if let stock = self.stock {
            param["stock"] = stock
        }
        if let discountedPrice = self.discountedPrice {
            param["discounted_price"] = discountedPrice
        }
        if let password = self.password {
            param["password"] = password
        }
        return param
    }
}

struct DeleteParameterData: Encodable {
    let password: String
}

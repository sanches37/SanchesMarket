//
//  EditText.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/30.
//

import Foundation

enum EditParameter: String {
    case title = "상품명"
    case currency = "화폐단위"
    case price = "가격"
    case discountedPrice = "할인가격"
    case stock = "재고수량"
    case description = "상세설명"
}

enum EditEssentialElement {
    case post
    case patch
    
    var text: [String] {
        switch self {
        case .post:
            return [EditParameter.title.rawValue,
                    EditParameter.currency.rawValue,
                    EditParameter.price.rawValue,
                    EditParameter.stock.rawValue,
                    EditParameter.description.rawValue]
        case .patch:
            return []
        }
    }
    var minimumImage: Int {
        switch self {
        case .post:
            return 1
        case .patch:
            return .zero
        }
    }
}

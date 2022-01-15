//
//  Int+extension.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/15.
//

import Foundation

extension Int {
    var withComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: self) ?? ""
        return result
    }
}

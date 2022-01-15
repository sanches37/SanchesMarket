//
//  String+extension.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/15.
//

import UIKit

extension String {
    var strikeThrough: NSAttributedString {
        let attributeString: NSMutableAttributedString =
            NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
}

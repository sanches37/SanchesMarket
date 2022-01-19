//
//  LodingIndicatorProtocol.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import Foundation

protocol LodingIndicatable: AnyObject {
    func startAnimating()
    func stopAnimating()
    func isHidden(_ isHidden: Bool)
}

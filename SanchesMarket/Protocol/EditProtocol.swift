//
//  EditProtocol.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/31.
//

import Foundation

protocol Editable {
    var essentialElement: EditEssentialElement { get }
    var requestAPI: Requestable { get }
}

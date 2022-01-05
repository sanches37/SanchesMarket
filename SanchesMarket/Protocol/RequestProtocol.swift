//
//  Requestable.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

protocol Requestable {
    var url: APIURL { get }
    var httpMethod: APIHTTPMethod { get }
    var contentType: ContentType { get }
}

protocol RequestableWithMultipartForm: Requestable {
    var parameter: [String: Any] { get }
    var image: [Media]? { get }
}


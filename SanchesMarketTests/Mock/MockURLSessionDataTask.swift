//
//  MockURLSessionDataTask.swift
//  SanchesMarketTests
//
//  Created by tae hoon park on 2022/01/06.
//

import Foundation
@testable import SanchesMarket

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeDidCall: () -> Void = {}
}

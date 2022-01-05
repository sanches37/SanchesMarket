//
//  RequestApi.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import Foundation

struct GetItemApi: Requestable {
    var url: APIURL
    let httpMethod: APIHTTPMethod = .get
    let contentType: ContentType = .json
    
    init(id: Int) {
        self.url = .getItem(id: id)
    }
}

struct GetItemsApi: Requestable {
    var url: APIURL
    let httpMethod: APIHTTPMethod = .get
    let contentType: ContentType = .json
    
    init(page: Int) {
        self.url = .getItems(page: page)
    }
}

struct PostAPI: RequestableWithMultipartForm {
    var url: APIURL = .post
    let httpMethod: APIHTTPMethod = .post
    let contentType: ContentType = .multipart
    var parameter: [String : Any]
    var image: [Media]?
    
    init(parameter: [String: Any], image:[Media]) {
        self.parameter = parameter
        self.image = image
    }
}

struct PatchAPI: RequestableWithMultipartForm {
    var url: APIURL
    let httpMethod: APIHTTPMethod = .patch
    let contentType: ContentType = .multipart
    var parameter: [String : Any]
    var image: [Media]?
    
    init(id: Int, parameter: [String: Any], image:[Media]) {
        self.url = .patch(id: id)
        self.parameter = parameter
        self.image = image
    }
}

struct DeleteApi: Requestable {
    var url: APIURL
    let httpMethod: APIHTTPMethod = .delete
    let contentType: ContentType = .json
    var password: DeleteParameterData
    
    init(id: Int, password: String) {
        self.url = .getItem(id: id)
        self.password = DeleteParameterData(password: password)
    }
}
